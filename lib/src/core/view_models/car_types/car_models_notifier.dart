import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/car_types/car_models_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/car/car_model.dart';
//----------------------------------------------------------------

final modelsSearchProvider = StateProvider.autoDispose((ref) {
  List<CarModel> carModels = ref.watch(modelsProvider).carModels;
  String searchKeyword = ref.watch(modelsProvider).searchKeyword;

  return carModels.where((model) {
    // note that models names are converted to lower case
    // so that results become case-insensitive.
    String arModelName = model.name["ar"].toLowerCase();
    String enModelName = model.name["en"].toLowerCase();

    bool similarArName = arModelName.contains(searchKeyword);
    bool similarEnName = enModelName.contains(searchKeyword);

    return similarArName || similarEnName;
  }).toList();
});

final modelsProvider = ChangeNotifierProvider.autoDispose((_) {
  return CarModelsNotifier();
});

class CarModelsNotifier extends ChangeNotifier {
  bool isLoading = true;

  String searchKeyword = "";
  String? errorId;

  List<CarModel> carModels = [];

  void changeSearchKeywordState(String newKeyword) {
    // note that converting search keywords to lower case
    // makes search results accurate.
    searchKeyword = newKeyword.toLowerCase();
    notifyListeners();
  }

  Future<void> getCarModels(int brandId, BuildContext context) async {
    HttpClientResult result = await CarModelsClient().fetchModels(brandId);
    if (result is SuccessfulRequest) {
      carModels = result.retrievedData;
      errorId = null;
    } else if (result is FailedRequest) {
      errorId = result.errorId;
    }

    isLoading = false;
    notifyListeners();
  }
}
