import 'package:hive/hive.dart';
//------------------------------
part 'home_banner.g.dart';
//------------------------

@HiveType(typeId: 13)
class HomeBanner extends HiveObject {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final String imageUrl;

  /// home banner title in all languages.
  @HiveField(3)
  late final Map title;

  /// home banner description in all languages.
  @HiveField(4)
  late final Map description;

  /// default constructor to make
  /// hive_generator runs successfully.
  HomeBanner();

  HomeBanner.fromJson(Map map) {
    id = map["id"];
    imageUrl = map["image"];
    title = {
      "ar": map["name_ar"] ?? "",
      "en": map["name_en"] ?? "",
    };
    description = {
      "ar": map["description_ar"] ?? "",
      "en": map["description_en"] ?? "",
    };
  }
}
