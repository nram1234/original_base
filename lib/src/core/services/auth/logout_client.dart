import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/services/notifications/firebase_messaging_service.dart';
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class LogoutClient {
  final _httpClient = Dio();

  LogoutClient() {
    User _user = LoggedInUserHelper().storedUser!;
    _httpClient.options.headers = {
      "Authorization": "Bearer ${_user.token}",
    };
  }

  Future<HttpClientResult> logout() async {
    try {
      await _httpClient.get(APIs.logout);
      FirebaseMessagingService().invalidateDevicePushToken();
      return SuccessfulRequest();
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
