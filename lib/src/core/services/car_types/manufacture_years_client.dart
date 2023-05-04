import 'package:dio/dio.dart';
import 'package:original_base/original_base.dart';
//------------------------------------------------
import 'package:original_base/src/config/apis.dart';
//--------------------------------------------------

class YearsOfManufactureClient {
  final _httpClient = Dio();

  Future<HttpClientResult> fetchYears(int modelId) async {
    try {
      Response response = await _httpClient.get(
        APIs.yearsOfManufacture + "/$modelId",
      );

      List results = response.data["data"]["years"];
      List<CarYearOfManufacture> yearsOfManufacture = results.map((yearMap) {
        return CarYearOfManufacture.fromJson(yearMap);
      }).toList();
      return SuccessfulRequest(yearsOfManufacture);
    } catch (error, stackTrace) {
      String errorId = resolveClientError(error, stackTrace);
      return FailedRequest(errorId);
    }
  }
}
