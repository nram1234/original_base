import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/models/product/product.dart';
//------------------------------------------------------------------
part 'favorite_product.g.dart';
//-----------------------------

@HiveType(typeId: 7)
class FavoriteProduct extends HiveObject {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final Product product;

  /// default constructor to make
  /// hive_generator runs successfully.
  FavoriteProduct();

  FavoriteProduct.fromJson(Map map) {
    id = map["id"];
    product = Product.fromJson(map["product"]);
  }
}
