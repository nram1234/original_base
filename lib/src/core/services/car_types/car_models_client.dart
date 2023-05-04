import 'package:dio/dio.dart';
import 'package:original_base/original_base.dart';
//------------------------------------------------
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class CarModelsClient {
  final _httpClient = Dio();

  Future<HttpClientResult> fetchModels(int brandId) async {
    try {
      Response response = await _httpClient.get(
        APIs.carModels + "/$brandId",
      );

      List jsonResults = response.data["data"];
      List<CarModel> carModels = jsonResults.map((map) {
        return CarModel.fromJson(map);
      }).toList();
      return SuccessfulRequest(carModels);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
