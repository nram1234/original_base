import 'package:dio/dio.dart';
//------------------------------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/utils/client_error_resolver.dart';
import 'package:original_base/src/core/models/car/car_brand.dart';
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class CarBrandsClient {
  final _httpClient = Dio();

  Future<HttpClientResult> fetchBrands() async {
    try {
      Response response = await _httpClient.get(APIs.carBrands);

      List jsonResults = response.data["data"];
      List<CarBrand> carBrands = jsonResults.map((map) {
        return CarBrand.fromJson(map);
      }).toList();
      return SuccessfulRequest(carBrands);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
