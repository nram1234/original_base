import 'package:dio/dio.dart';
//------------------------------------------------
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class PeerInfoClient {
  final _httpClient = Dio();

  Future<User?> getPeerData(String peerId) async {
    try {
      Response response = await _httpClient.get(
        APIs.singleUser + "/$peerId",
      );

      Map jsonResult = response.data;
      if (jsonResult["data"] != null) {
        User peerInfo = User.fromJson(
          jsonResult,
          includeAccessToken: false,
        );
        return peerInfo;
      }
    } catch (error, stackTrace) {
      resolveClientError(error, stackTrace);
    }

    return null;
  }
}
