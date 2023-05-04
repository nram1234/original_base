import 'package:original_base/src/core/models/store/store_category.dart';
import 'package:original_base/src/core/models/store/trade_type.dart';
import 'package:original_base/src/core/models/store/store_city.dart';
import 'package:original_base/src/core/models/car/car_brand.dart';
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------

class Store {
  late final int id;

  late final String name;
  late final String address;

  late final User dealer;

  late final List<CarBrand> brands;
  late final List<TradeType> tradeTypes;
  late final List<StoreCity> storeCities;
  late final List<StoreCategory> storeCategories;

  Store.fromJson(Map map) {
    id = map["id"];
    name = map["name"];
    address = map["address"];

    dealer = User.fromJson(
      {"data": map["dealer"]},
      includeAccessToken: false,
    );

    List brandsData = map["marks"];
    brands = brandsData.map((brandData) {
      return CarBrand.fromJson(brandData);
    }).toList();

    List tradeTypesData = map["trade"];
    tradeTypes = tradeTypesData.map((tradeTypeData) {
      return TradeType.fromJson(tradeTypeData);
    }).toList();

    List storeCitiesData = map["addresses"];
    storeCities = storeCitiesData.map((cityData) {
      return StoreCity.fromJson(cityData);
    }).toList();

    List categoriesData = map["categories"];
    storeCategories = categoriesData.map((categoryData) {
      return StoreCategory.fromJson(categoryData);
    }).toList();
  }
}
