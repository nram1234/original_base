import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/models/store/store_review.dart';
import 'package:original_base/src/core/utils/numeral_extensions.dart';
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------
part 'product.g.dart';
//--------------------

@HiveType(typeId: 2)
class Product extends HiveObject {
  @HiveField(0)
  late final bool approved;

  @HiveField(1)
  late final bool usedProduct;

  @HiveField(2)
  late final int id;

  @HiveField(3)
  late final int quantity;

  @HiveField(4)
  late final double originalPrice;

  @HiveField(5)
  late final double totalRating;

  @HiveField(6)
  late final double priceAfterOffer;

  @HiveField(7)
  late final String arName;

  @HiveField(8)
  late final String enName;

  @HiveField(9)
  late final String thumbnailImage;

  @HiveField(10)
  late final String arOriginCountry;

  @HiveField(11)
  late final String enOriginCountry;

  @HiveField(12)
  late final String guaranteeCompany;

  @HiveField(13)
  late final String arGuaranteePeriod;

  @HiveField(14)
  late final String enGuaranteePeriod;

  @HiveField(15)
  late final List imagesUrls;

  @HiveField(16)
  late final DateTime dateAdded;

  @HiveField(17)
  late final int? offerPercentage;

  @HiveField(18)
  late final Map compatibleCars;

  @HiveField(19)
  late final StoreReview? firstReview;

  @HiveField(20)
  late final User dealer;

  @HiveField(21)
  late final int categoryId;

  /// default constructor to make
  /// hive_generator runs successfully.
  Product();

  Product.fromJson(Map map) {
    approved = map["approve"] == 1 ? true : false;
    usedProduct = int.parse(map["used"]) == 1 ? false : true;
    id = map["id"];
    quantity = int.parse(map["quantity"]);
    originalPrice = (map["price"].toDouble() as double).toPercentageAccuracy;
    totalRating = double.parse(map["total_rating"]).toPercentageAccuracy;
    arName = map["name_ar"];
    enName = map["name_en"];
    thumbnailImage = map["image"];
    arOriginCountry = map["made_in_ar"];
    enOriginCountry = map["made_in_en"];
    guaranteeCompany = map["guarante"];
    arGuaranteePeriod = map["guarante_period_ar"];
    enGuaranteePeriod = map["guarante_period_en"];
    imagesUrls = map["images"];
    dateAdded = DateTime.parse(map["created_at"]);
    categoryId = map["category"]["id"];
    offerPercentage = map["percentage"];

    compatibleCars = {
      "ar": map["compatible_cars_ar"] ?? "",
      "en": map["compatible_cars_en"] ?? "",
    };

    if (offerPercentage != null && offerPercentage != 0) {
      double offerDiscount = (originalPrice / 100) * offerPercentage!;
      priceAfterOffer = (originalPrice - offerDiscount).toPercentageAccuracy;
    } else {
      priceAfterOffer = originalPrice;
    }

    List reviewsData = map["ratings"];
    if (reviewsData.isNotEmpty) {
      firstReview = StoreReview.fromJson(reviewsData.first);
    } else {
      firstReview = null;
    }

    dealer = User.fromJson(
      {"data": map["dealer"]},
      includeAccessToken: false,
    );
  }
}
