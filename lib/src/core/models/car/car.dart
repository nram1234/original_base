import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/models/car/year_of_manufacture.dart';
import 'package:original_base/src/core/models/car/car_engine.dart';
import 'package:original_base/src/core/models/car/car_brand.dart';
import 'package:original_base/src/core/models/car/car_model.dart';
//----------------------------------------------------------------
part 'car.g.dart';
//----------------

@HiveType(typeId: 8)
class Car extends HiveObject {
  @HiveField(1)
  late final int id;

  /// car name in all languages.
  @HiveField(2)
  late final Map name;

  @HiveField(3)
  late final CarBrand brand;

  @HiveField(4)
  late final CarModel model;

  @HiveField(5)
  late final CarEngine engine;

  @HiveField(6)
  late final CarYearOfManufacture yearOfManufacture;

  /// default constructor to make
  /// hive_generator runs successfully.
  Car();

  Car.fromJson(Map map) {
    id = map["id"];
    name = {
      "ar": map["name_ar"],
      "en": map["name_en"],
    };
    brand = CarBrand.fromJson(map["mark"]);
    model = CarModel.fromJson(map["model"]);
    engine = CarEngine.fromJson(map["engine"]);
    yearOfManufacture = CarYearOfManufacture.fromJson(map["year"]);
  }

  Map get data {
    return {
      "id": id,
      "name_en": name["en"],
      "name_ar": name["ar"],
      "mark": brand.map,
      "model": model.map,
      "engine": engine.map,
      "year": yearOfManufacture.map,
    };
  }
}
