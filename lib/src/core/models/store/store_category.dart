class StoreCategory {
  late final int id;

  late final String nameAr;
  late final String nameEn;

  StoreCategory.fromJson(Map map) {
    id = map["id"];
    nameAr = map["name_ar"];
    nameEn = map["name_en"];
  }
}
