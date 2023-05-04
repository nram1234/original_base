import 'dart:io';
//---------------
import 'package:dio/dio.dart';
import 'package:original_base/original_base.dart';
//------------------------------------------------
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class ChatMediaFilesUploader {
  final _uploadClient = Dio();

  Future<HttpClientResult> uploadFile({
    required File file,
    required String mediaType,
  }) async {
    try {
      Response response = await _uploadClient.post(
        APIs.chatMediaUpload,
        data: FormData.fromMap({
          "type": mediaType == "image" ? 0 : 1,
          "file": MultipartFile.fromFileSync(file.path),
        }),
      );

      String uploadedFileUrl = response.data["data"]["file"];
      return SuccessfulRequest(uploadedFileUrl);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
