import 'package:dio/dio.dart';
//----------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/core/models/store/store_city.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class MerchantsCitiesClient {
  final _httpClient = Dio();

  Future<HttpClientResult> fetchCities() async {
    try {
      Response response = await _httpClient.get(APIs.merchantsCities);

      List jsonResults = response.data["data"];
      List<StoreCity> storesCities = jsonResults.map((itemData) {
        return StoreCity.fromJson(itemData);
      }).toList();

      return SuccessfulRequest(storesCities);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
