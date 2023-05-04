import 'package:hive/hive.dart';
//------------------------------
part 'car_model.g.dart';
//----------------------

@HiveType(typeId: 11)
class CarModel {
  @HiveField(1)
  late final int id;

  /// model name in all languages.
  @HiveField(2)
  late final Map name;

  /// default constructor to make
  /// hive_generator runs successfully.
  CarModel();

  CarModel.fromJson(Map map) {
    id = map["id"];
    name = {
      "ar": map["name_ar"],
      "en": map["name_en"],
    };
  }

  Map get map {
    return {
      "id": id,
      "name_ar": name["ar"],
      "name_en": name["en"],
    };
  }
}
