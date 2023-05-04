import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/car_types/car_brands_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/car/car_brand.dart';
//----------------------------------------------------------------

final brandsSearchProvider = StateProvider.autoDispose((ref) {
  List<CarBrand> carBrands = ref.watch(brandsProvider).carBrands;
  String searchKeyword = ref.watch(brandsProvider).searchKeyword;

  return carBrands.where((brand) {
    // note that brands names are converted to lower case
    // so that results become case-insensitive.
    String arBrandName = brand.name["ar"].toLowerCase();
    String enBrandName = brand.name["en"].toLowerCase();

    bool similarArName = arBrandName.contains(searchKeyword);
    bool similarEnName = enBrandName.contains(searchKeyword);

    return similarArName || similarEnName;
  }).toList();
});

final brandsProvider = ChangeNotifierProvider.autoDispose((_) {
  return CarBrandsNotifier();
});

class CarBrandsNotifier extends ChangeNotifier {
  bool isLoading = true;

  String searchKeyword = "";
  String? errorId;

  List<CarBrand> carBrands = [];

  void changeSearchKeywordState(String newKeyword) {
    // note that converting search keywords to lower case
    // makes search results accurate.
    searchKeyword = newKeyword.toLowerCase();
    notifyListeners();
  }

  Future<void> getCarBrands(BuildContext context) async {
    HttpClientResult result = await CarBrandsClient().fetchBrands();
    if (result is SuccessfulRequest) {
      carBrands = result.retrievedData;
      errorId = null;
    } else if (result is FailedRequest) {
      errorId = result.errorId;
    }

    isLoading = false;
    notifyListeners();
  }
}
