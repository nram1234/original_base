import 'package:hive/hive.dart';
//------------------------------
part 'car_engine.g.dart';
//-----------------------

@HiveType(typeId: 10)
class CarEngine {
  @HiveField(1)
  late final int id;

  /// engine name in all languages.
  @HiveField(2)
  late final Map name;

  /// default constructor to make
  /// hive_generator runs successfully.
  CarEngine();

  CarEngine.fromJson(Map map) {
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
