class ProductAttribute {
  late final int id;

  late final String nameAr;
  late final String nameEn;
  late final String? thumbnailImage;

  ProductAttribute.all() {
    id = 0;
    nameAr = "الكل";
    nameEn = "All";
    thumbnailImage = null;
  }

  ProductAttribute.fromJson(Map map) {
    id = map["id"];
    nameAr = map["name_ar"];
    nameEn = map["name_en"];
    thumbnailImage = map["thumbnail"];
  }
}
