import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/car_types/manufacture_years_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/car/year_of_manufacture.dart';
//--------------------------------------------------------------------------

final yearsOfManufactureSearchProvider = StateProvider.autoDispose((ref) {
  List yearsOfManufacture = ref.watch(yearsOfManufactureProvider).years;
  String searchKeyword = ref.watch(yearsOfManufactureProvider).searchKeyword;

  return yearsOfManufacture.where((element) {
    return element.year.toString().contains(searchKeyword);
  }).toList();
});

final yearsOfManufactureProvider = ChangeNotifierProvider.autoDispose((_) {
  return YearsOManufacturerNotifier();
});

class YearsOManufacturerNotifier extends ChangeNotifier {
  bool isLoading = true;

  String searchKeyword = "";
  String? errorId;

  List<CarYearOfManufacture> years = [];

  void changeSearchKeywordState(String newKeyword) {
    searchKeyword = newKeyword;
    notifyListeners();
  }

  Future<void> getYearsOfManufacture(int modelId, BuildContext context) async {
    var result = await YearsOfManufactureClient().fetchYears(modelId);
    if (result is SuccessfulRequest) {
      years = result.retrievedData;
      errorId = null;
    } else if (result is FailedRequest) {
      errorId = result.errorId;
    }

    isLoading = false;
    notifyListeners();
  }
}
