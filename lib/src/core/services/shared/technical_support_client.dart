import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class TechnicalSupportClient {
  final _httpClient = Dio();

  Future<HttpClientResult> sendMessage({
    required String userName,
    required String email,
    required String message,
  }) async {
    try {
      await _httpClient.post(
        APIs.technicalSupport,
        data: {
          "name": userName.trim(),
          "email": email,
          "message": message.trim(),
        },
      );
      return SuccessfulRequest();
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
