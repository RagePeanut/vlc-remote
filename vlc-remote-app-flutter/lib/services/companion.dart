import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/history/history.dart';
import '../models/media/media.dart';
import '../stores/files/files.dart';
import '../stores/status/status.dart';
import 'vlc.dart';

class Companion {
    static const int CONNECTION_TIMEOUT = 500000;
    static const Duration MEDIAS_EXTRA_INFO_CHECK_INTERVAL = const Duration(milliseconds: 1000);

    static Dio _dio;
    static Files _files;
    static Status _status;

    static List<Media> _mediasRequiringExtraInfo = [];
    
    static Future<void> init(Files files, Status status) async {
        Companion._files = files;
        Companion._status = status;
        _dio = Dio(
            BaseOptions(
                validateStatus: (status) => status < 500,
            ),
        );
    }

    static void start() {
        if(_files.currentComputer != null) _files.connectToComputer(_files.currentComputer);
        _checkMediasRequiringExtraInfo();
    }

    static _checkMediasRequiringExtraInfo() async {
        List<Media> medias = _mediasRequiringExtraInfo.sublist(0);
        _mediasRequiringExtraInfo.clear();
        await Future.wait(medias.map((Media media) => extraInfo(media)));
        Future.delayed(MEDIAS_EXTRA_INFO_CHECK_INTERVAL, _checkMediasRequiringExtraInfo);
    }

    static Future<Response> get(String action, [ Map<String, dynamic> queryParameters, ResponseType responseType ]) async {
        if(_files.currentComputer != null) {
            try {
                String url = "http://${_files.currentComputer.ipAddress}:${_files.currentComputer.companionPort}/$action";
                Response response = await _dio.get(
                    url,
                    queryParameters: queryParameters,
                    options: RequestOptions(
                        connectTimeout: responseType == ResponseType.stream ? null : CONNECTION_TIMEOUT,
                        responseType: responseType,
                        headers: responseType == ResponseType.stream ? {
                            HttpHeaders.connectionHeader: "keep-alive",
                        } : {},
                    ),
                );
                return response;
            } on DioError catch(error) {
                print("(Companion) $error");
            }
        }
        return null;
    }

    static Future<void> extraInfo(Media media) async {
        Response response = await get("extra_info", { "uri": media.file.uri }, ResponseType.stream);
        if(response == null) {
            _mediasRequiringExtraInfo.add(media);
        } else if(response.statusCode == 200) {
            Stream stream = response.data.stream;
            StreamSubscription<String> sub = utf8.decoder.bind(stream).listen((event) {
                media.addExtraInfo((json.decode(event)));
            });
            sub.onDone(() => sub.cancel());
        }
    }

    static Future<void> power() async {
        bool wasOn = _status.isOn ?? false;
        Response response = wasOn ? await get("close_vlc")
                                  : await get("open_vlc");
        if(response?.statusCode == 200) {
            _status.switchPower(wasOn);
            if(wasOn) {
                _files.reset();
            } else {
                History history = _files.currentComputer.history;
                VLC.browse(history.path, history.uri);
            }
        }
    }

    static Future<void> switchScreen() async {
        Response response = await get("switch_screen");
        if(response?.statusCode == 200) {
            _files.updateScreenNumber(response.data["current_screen"]);
        }
    }

}