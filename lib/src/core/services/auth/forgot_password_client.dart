import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/config/errors_ids.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class ForgotPasswordClient {
  final _httpClient = Dio();

  Future<HttpClientResult> requestResetCode(String email) async {
    try {
      Response response = await _httpClient.post(
        APIs.forgotPassword,
        data: {"email": email},
      );

      Map jsonResult = response.data;
      if (jsonResult["message"] == APIsMessages.passwordResetEmailSent) {
        return SuccessfulRequest();
      } else if (jsonResult["email"] != null) {
        return FailedRequest(ErrorsIds.noMatchingEmailFound);
      } else {
        return FailedRequest(ErrorsIds.internalError);
      }
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
