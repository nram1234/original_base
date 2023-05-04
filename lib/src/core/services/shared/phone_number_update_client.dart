import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/services/local_storage/logged_in_user_helper.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/config/errors_ids.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class PhoneNumberUpdateClient {
  final _httpClient = Dio();

  PhoneNumberUpdateClient() {
    User _user = LoggedInUserHelper().storedUser!;
    _httpClient.options.headers = {
      "Authorization": "Bearer ${_user.token}",
    };
  }

  Future<HttpClientResult> updatePhoneNumber(String newPhoneNumber) async {
    try {
      Response response = await _httpClient.post(
        APIs.updateProfile,
        data: {"phone": newPhoneNumber},
      );

      if (response.data == "The phone has already been taken.") {
        return FailedRequest(ErrorsIds.phoneNumberTaken);
      }

      User updatedUser = User.fromJson(response.data);
      return SuccessfulRequest(updatedUser);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
