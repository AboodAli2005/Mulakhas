import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  final Dio _dio = Dio();

  Future<String?> downloadFile({
    required String fileUrl,
    required String fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final sanitizedName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final savePath = '${dir.path}/$sanitizedName';

      final file = File(savePath);
      if (await file.exists()) {
        return savePath;
      }

      await _dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: onProgress,
      );

      return savePath;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isFileDownloaded(String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final sanitizedName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final file = File('${dir.path}/$sanitizedName');
      return await file.exists();
    } catch (_) {
      return false;
    }
  }
}
