import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/models/user.dart';
//-------------------------------------------------------
part 'store_review.g.dart';
//-------------------------

@HiveType(typeId: 6)
class StoreReview extends HiveObject {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final double rating;

  @HiveField(3)
  late final String comment;

  @HiveField(4)
  late final User owner;

  @HiveField(5)
  late final DateTime dateAdded;

  /// default constructor to make
  /// hive_generator runs successfully.
  StoreReview();

  StoreReview.fromJson(Map map) {
    id = map["id"];
    rating = map["rate"].toDouble();
    comment = map["review"];
    dateAdded = DateTime.parse(map["created_at"]);
    owner = User.fromJson(
      {"data": map["user"]},
      includeAccessToken: false,
    );
  }
}
