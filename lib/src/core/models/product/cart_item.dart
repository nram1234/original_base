import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/utils/numeral_extensions.dart';
import 'package:original_base/src/core/models/product/product.dart';
//------------------------------------------------------------------
part 'cart_item.g.dart';
//----------------------

@HiveType(typeId: 4)
class CartItem extends HiveObject {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final int quantity;

  @HiveField(3)
  late final double originalPrice;

  @HiveField(4)
  late final double priceAfterOffer;

  @HiveField(5)
  late final Product product;

  /// default constructor to make
  /// hive_generator runs successfully.
  CartItem();

  CartItem.fromJson(Map map) {
    id = map["id"];
    quantity = map["qty"];
    double priceInfo = map["price"].toDouble();
    originalPrice = priceInfo.toPercentageAccuracy;
    double priceAfterOfferInfo = map["price_after_discount"].toDouble();
    priceAfterOffer = priceAfterOfferInfo.toPercentageAccuracy;
    product = Product.fromJson(map["product"]);
  }
}
