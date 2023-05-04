import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/car_types/car_engines_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/car/car_engine.dart';
//-----------------------------------------------------------------

final enginesSearchProvider = StateProvider.autoDispose((ref) {
  List<CarEngine> carEngines = ref.watch(enginesProvider).carEngines;
  String searchKeyword = ref.watch(enginesProvider).searchKeyword;

  return carEngines.where((engine) {
    // note that engines names are converted to lower case
    // so that results become case-insensitive.
    String arEngineName = engine.name["ar"].toLowerCase();
    String enEngineName = engine.name["en"].toLowerCase();

    bool similarArName = arEngineName.contains(searchKeyword);
    bool similarEnName = enEngineName.contains(searchKeyword);

    return similarArName || similarEnName;
  }).toList();
});

final enginesProvider = ChangeNotifierProvider.autoDispose((_) {
  return CarEnginesNotifier();
});

class CarEnginesNotifier extends ChangeNotifier {
  bool isLoading = true;

  String searchKeyword = "";
  String? errorId;

  List<CarEngine> carEngines = [];

  void changeSearchKeywordState(String newKeyword) {
    // note that converting search keywords to lower case
    // makes search results accurate.
    searchKeyword = newKeyword.toLowerCase();
    notifyListeners();
  }

  Future<void> getCarEngines(int modelId, BuildContext context) async {
    HttpClientResult result = await CarEnginesClient().fetchEngines(modelId);
    if (result is SuccessfulRequest) {
      carEngines = result.retrievedData;
      errorId = null;
    } else if (result is FailedRequest) {
      errorId = result.errorId;
    }

    isLoading = false;
    notifyListeners();
  }
}
