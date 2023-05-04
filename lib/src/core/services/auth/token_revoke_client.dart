import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class TokenRevokeClient {
  final _httpClient = Dio();

  Future<HttpClientResult> revokeToken({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      Response response = await _httpClient.post(
        APIs.revokeToken,
        data: {
          "phone": phoneNumber,
          "password": password.trim(),
        },
      );

      Map jsonResult = response.data;
      User revokedUser = User.fromJson(jsonResult);
      return SuccessfulRequest(revokedUser);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }

  Future<HttpClientResult> revokeSocialToken({
    required String provider,
    required String providerId,
  }) async {
    try {
      Response response = await _httpClient.post(
        APIs.socialTokenRevoke,
        data: {
          "provider": provider,
          "provider_id": providerId,
        },
      );

      Map jsonResult = response.data;
      User revokedUser = User.fromJson(jsonResult);
      return SuccessfulRequest(revokedUser);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
