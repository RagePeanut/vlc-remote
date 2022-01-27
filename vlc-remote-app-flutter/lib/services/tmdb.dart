import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/file/file.dart';
import '../models/poster_configuration.dart';
import '../stores/files/files.dart';
import '../utils/locale/app_locale.dart';
import '../utils/regex.dart';

class TMDb {
    static Dio _dio;
    static PosterConfiguration _posterConfig;
    static Files files;

    static Future<void> init(Files files) async {
        TMDb.files = files;
        _dio = Dio(
            BaseOptions(
                baseUrl: env["API_URL"],
                validateStatus: (status) => status < 500,
            ),
        );
        await _initPosterConfig();
    }

    static Future<void> _initPosterConfig() async {
        Response response = await _dio.get("/configuration");
        if(response.statusCode == 200) {
            _posterConfig = PosterConfiguration(data: Map<String, dynamic>.from(response.data));
        }
    }

    static Future<void> findMedia(File file) async {
        String fileName = file.name.replaceFirst(extensionRegex, "");
        Response response = await _dio.get(
            "/find",
            queryParameters: {
                "query": fileName,
                "language": locale.currentLocale.toString(),
            },
        );
        if(response.statusCode == 200) {
            Map<String, dynamic> media = Map<String, dynamic>.from(response.data);
            files.updateMedia(file, media);
        } else {
            files.setMediaAsNonMedia(file);
        }
    }

    static Future<bool> fixMedia(String id, File file) async {
        Response response = await _dio.get(
            "/find_by_id",
            queryParameters: {
                "id": id,
                "language": locale.currentLocale.toString(),
            },
        );
        if(response.statusCode == 200) {
            Map<String, dynamic> media = Map<String, dynamic>.from(response.data);
            files.updateMedia(file, media);
            return true;
        }
        files.setMediaAsNonMedia(file);
        return false;
    }

    static String getPosterUrl(String path, [ double width ]) {
        if(width == null) {
            return _posterConfig.getPosterUrl(path);
        }
        return _posterConfig.getPosterUrlForWidth(path, width);
    }
}