import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/models/product/favorite_product.dart';
import 'package:original_base/src/core/models/product/cart_item.dart';
import 'package:original_base/src/core/models/product/product.dart';
import 'package:original_base/src/core/models/home_banner.dart';
//--------------------------------------------------------------

/// This class contains all hive boxes and their names.
class HiveBoxes {
  static const String carInfoBoxName = "car_info";
  static const String cartItemsBoxName = "cart_items";
  static const String bestSellerBoxName = "best_seller";
  static const String cachedInfoBoxName = "cached_info";
  static const String homeBannersBoxName = "home_banners";
  static const String loggedInUserBoxName = "logged_in_user";
  static const String latestOffersBoxName = "latest_offers";
  static const String favoriteProductsBoxName = "favorite_products";

  static final carInfo = Hive.box(carInfoBoxName);
  static final cachedInfo = Hive.box(cachedInfoBoxName);
  static final homeBanners = Hive.box<HomeBanner>(homeBannersBoxName);
  static final loggedInUser = Hive.box(loggedInUserBoxName);
  static final cartItems = Hive.box<CartItem>(cartItemsBoxName);
  static final bestSeller = Hive.box<Product>(bestSellerBoxName);
  static final latestOffers = Hive.box<Product>(latestOffersBoxName);
  static final favoriteProducts =
      Hive.box<FavoriteProduct>(favoriteProductsBoxName);
}
