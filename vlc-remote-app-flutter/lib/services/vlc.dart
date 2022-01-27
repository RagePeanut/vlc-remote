import 'dart:async';
import 'dart:convert';
import 'dart:io' hide File;

import 'package:dio/dio.dart';

import '../models/file/file.dart';
import '../models/history/history.dart';
import '../models/playlist_file.dart';
import '../stores/files/files.dart';
import '../stores/status/status.dart';

class VLC {
    static const int MAX_VOLUME = 320;
    static const int CONNECTION_TIMEOUT = 5000;
    static const Duration STATUS_REFRESH_INTERVAL = const Duration(milliseconds: 200);
    static const Duration PLAYLIST_REFRESH_INTERVAL = const Duration(milliseconds: 500);

    static Dio _dio;
    static Files _files;
    static Status _status;

    static Future<void> init(Files files, Status status) async {
        VLC._files = files;
        VLC._status = status;
        _dio = Dio();
    }

    static void start() {
        if(_files.currentComputer != null) _files.connectToComputer(_files.currentComputer);
        Timer.periodic(PLAYLIST_REFRESH_INTERVAL, (timer) => _playlistRequest());
        Timer.periodic(STATUS_REFRESH_INTERVAL, (timer) => _statusRequest());
    }

    static Future<Response> get(String type, [ Map<String, dynamic> queryParameters ]) async {
        if(_files.currentComputer != null) {
            try {
                String url = "http://${_files.currentComputer.ipAddress}:${_files.currentComputer.vlcPort}/requests/$type.json";
                Response response = await _dio.get(
                    url,
                    queryParameters: queryParameters,
                    options: RequestOptions(
                        headers: {
                            "Authorization": "Basic " + base64.encode(utf8.encode(":${_files.currentComputer.password}")),
                        },
                        connectTimeout: CONNECTION_TIMEOUT,
                    ),
                );
                return response;
            } on DioError catch(error) {
                print(error.message);
                if(error.type != DioErrorType.CONNECT_TIMEOUT) {
                    _status.setOff();
                    _files.reset();
                }
                switch(error.type) {
                    case DioErrorType.DEFAULT:
                        if(!(error.error is HttpException) && error.error?.osError?.errorCode == 113) { // 113 == no route to host
                            // TODO: show snackbar saying the ip address is unreachable
                        }
                        break;
                    case DioErrorType.RESPONSE:
                        // TODO: show snackbar saying the password doesn't work
                        break;
                    case DioErrorType.CONNECT_TIMEOUT:
                        // TODO: show snackbar saying the port is unreachable
                        break;
                    default:
                        break;
                }
            }
        }
        return null;
    }

    static Future<void> _browseRequest(String path, String uri) async {
        Response response = await get("browse", { "uri": uri });
        if(response?.statusCode == 200) {
            Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(response.data));
            _files.updateDirectory(path, data);
        }
    }

    static Future<void> _playlistRequest() async {
        Response response = await get("playlist");
        if(response?.statusCode == 200) {
            Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(response.data));
            _files.updatePlaylist(data);
        }
    }

    static Future<void> _statusRequest({ String command, Map<String, String> args = const {} }) async {
        Map<String, String> params = command == null ? {} : { "command": command };
        Response response = await get("status", params..addAll(args));
        if(response?.statusCode == 200) {
            Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(response.data));
            _status.update(data, _files.playlistAsMedias);
        }
    }

    static Future<void> addToPlaylist(String uri) async {
        await _statusRequest(command: "in_enqueue", args: { "input": uri });
        await _playlistRequest();
    }

    static Future<void> browse(String path, String uri, [ bool isFromConnection = false ]) async {
        if(_dio != null) {
            await _browseRequest(path, uri);
            if(!isFromConnection) _files.currentComputer?.addHistoryEntry(path, uri);
        }
    }

    static Future<void> chapter(int val) async {
        _statusRequest(command: "chapter", args: { "val": val.toString() });
    }

    static Future<void> delete(String id) async {
        _statusRequest(command: "pl_delete", args: { "id": id });
    }

    static Future<void> fastForward(int val) async {
        seek("+" + val.toString());
    }

    static Future<void> fastRewind(int val) async {
        seek("-" + val.toString());
    }

    static Future<void> fullscreen() async {
        _statusRequest(command: "fullscreen");
    }

    static Future<void> moveToParent() async {
        History history = _files.currentComputer.history;
        if(history.parent != null) {
            await _browseRequest(history.parent.path, history.parent.uri);
            _files.currentComputer.removeLastHistoryEntry();
        }
    }

    static Future<void> nextChapter() async {
        if(_status.chapter + 1 < _status.chapterCount)
            chapter(_status.chapter + 1);
    }

    static Future<void> play(File file) async {
        if(!_files.playlist.any((PlaylistFile pfile) => pfile.uri == file.uri))
            await addToPlaylist(file.uri);
        String id = _files.playlist.lastWhere((PlaylistFile pfile) => pfile.uri == file.uri).id;
        await _statusRequest(command: "pl_play", args: { "id": id });
    }

    static Future<void> previousChapter() async {
        if(_status.chapter > 0) chapter(_status.chapter - 1);
    }

    static Future<void> seek(dynamic val) async {
        _statusRequest(command: "seek", args: { "val": val.toString() });
    }

    static Future<void> switchAudioTrack() async {
        _statusRequest(command: "key", args: { "val": "audio-track" });
    }

    static Future<void> switchSubtitleTrack() async {
        _statusRequest(command: "key", args: { "val": "subtitle-track" });
    }

    static Future<void> switchVideoTrack() async {
        _statusRequest(command: "key", args: { "val": "video-track" });
    }

    static Future<void> togglePause() async {
        _statusRequest(command: "pl_pause");
    }

    static Future<void> volume(int val) async {
        _statusRequest(command: "volume", args: { "val": val.toString() });
    }
}