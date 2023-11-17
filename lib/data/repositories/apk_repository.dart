import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/config.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:path_provider/path_provider.dart';

class ApkRepository {
  static Future<void> downloadApk({
    required void Function(double progress) progessCallback,
  }) async {
    try {
      final Dio dio = Dio(BaseOptions(baseUrl: apkUrl));
      String path = await _getFilePath(apkFileName);
      await dio.download(
        "",
        path,
        deleteOnError: true,
        onReceiveProgress: (count, total) => progessCallback(count / total),
      );
    } on DioException catch (e) {
      throw e.error as Object;
    }
  }

  static Future<String> _getFilePath(String fileName) async {
    Directory? dir;
    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      throw GenericError(message: "Cannot get download folder path $err");
    }
    return "${dir.path}$fileName";
  }
}
