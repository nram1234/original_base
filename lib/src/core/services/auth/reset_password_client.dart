import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/config/errors_ids.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class ResetPasswordClient {
  final _httpClient = Dio();

  Future<HttpClientResult> requestPasswordReset({
    required String email,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      Response response = await _httpClient.post(
        APIs.resetPassword,
        data: {
          "email": email,
          "token": verificationCode.trim(),
          "password": newPassword.trim(),
        },
      );

      String responseMessage = response.data["message"];
      if (responseMessage == APIsMessages.passwordResetDone) {
        return SuccessfulRequest();
      } else if (responseMessage == APIsMessages.wrongPasswordResetCode) {
        return FailedRequest(ErrorsIds.wrongVerificationCode);
      } else {
        return FailedRequest(ErrorsIds.internalError);
      }
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
