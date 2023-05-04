import 'package:dio/dio.dart';
import 'package:original_base/original_base.dart';
//------------------------------------------------
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class CarEnginesClient {
  final _httpClient = Dio();

  Future<HttpClientResult> fetchEngines(int modelId) async {
    try {
      Response response = await _httpClient.get(
        APIs.carEngines + "/$modelId",
      );

      List jsonResults = response.data["data"]["engines"];
      List<CarEngine> carEngines = jsonResults.map((map) {
        return CarEngine.fromJson(map);
      }).toList();
      return SuccessfulRequest(carEngines);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
