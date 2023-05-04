import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/shared/merchants_cities_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/store/store_city.dart';
//-------------------------------------------------------------------

final citiesSearchProvider = StateProvider.autoDispose((ref) {
  List<StoreCity> cities = ref.watch(citiesProvider).cities;
  String searchKeyword = ref.watch(citiesProvider).searchKeyword;

  return cities.where((city) {
    // note that cities names are converted to lower case
    // so that results become case-insensitive.
    String arCityName = city.nameAr.toLowerCase();
    String enCityName = city.nameEn.toLowerCase();

    bool similarArName = arCityName.contains(searchKeyword);
    bool similarEnName = enCityName.contains(searchKeyword);

    return similarArName || similarEnName;
  }).toList();
});

final citiesProvider = ChangeNotifierProvider.autoDispose((_) {
  return MerchantsCitiesNotifier();
});

class MerchantsCitiesNotifier extends ChangeNotifier {
  bool isLoading = true;

  String searchKeyword = "";
  String? errorId;

  List<StoreCity> cities = [];

  void changeSearchKeywordState(String newKeyword) {
    // note that converting search keywords to lower case
    // makes search results accurate.
    searchKeyword = newKeyword.toLowerCase();
    notifyListeners();
  }

  Future<void> getMerchantsCities() async {
    var result = await MerchantsCitiesClient().fetchCities();
    if (result is SuccessfulRequest) {
      cities = result.retrievedData;
      errorId = null;
    } else if (result is FailedRequest) {
      errorId = result.errorId;
    }

    isLoading = false;
    notifyListeners();
  }
}
