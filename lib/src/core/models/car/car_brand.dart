import 'package:hive/hive.dart';
//------------------------------
part 'car_brand.g.dart';
//----------------------

@HiveType(typeId: 9)
class CarBrand {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final String thumbnailUrl;

  /// brand name in all languages.
  @HiveField(3)
  late final Map name;

  /// default constructor to make
  /// hive_generator runs successfully.
  CarBrand();

  CarBrand.fromJson(Map map) {
    id = map["id"];
    thumbnailUrl = map["image"] ?? "";
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
      "image": thumbnailUrl,
    };
  }
}
