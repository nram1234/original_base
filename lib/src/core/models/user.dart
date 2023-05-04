import 'package:hive/hive.dart';
//------------------------------
import 'package:original_base/src/core/utils/numeral_extensions.dart';
//--------------------------------------------------------------------
part 'user.g.dart';
//------------------

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(1)
  late final bool accountApproved;

  @HiveField(2)
  late final bool phoneVerified;

  @HiveField(3)
  late final int id;

  @HiveField(4)
  late final String name;

  @HiveField(5)
  late final String email;

  @HiveField(6)
  late final String imageUrl;

  @HiveField(7)
  late final String phoneNumber;

  @HiveField(8)
  late final String address;

  @HiveField(9)
  late final String type;

  @HiveField(10)
  late final String token;

  @HiveField(11)
  late final double totalRating;

  @HiveField(12)
  late final bool trusted;

  /// default constructor to make
  /// hive_generator runs successfully.
  User();

  User.fromJson(Map map, {includeAccessToken = true}) {
    /// holds insensitive user information.
    Map publicData = map["data"];

    accountApproved = publicData["approve"] == 1 ? true : false;
    phoneVerified = publicData["phone_verified"] == 1 ? true : false;
    trusted = publicData["trusted"] == 1 ? true : false;
    id = publicData["id"];
    name = publicData["name"];
    email = publicData["email"];
    imageUrl = publicData["avatar"];
    phoneNumber = publicData["phone"];
    address = publicData["address"] ?? "";
    type = publicData["type"];
    token = includeAccessToken ? map["token"] : "";
    String? totalRatingInfo = map["total_rating"];
    if (totalRatingInfo != null) {
      totalRating = double.parse(map["total_rating"]).toPercentageAccuracy;
    } else {
      totalRating = 0.0;
    }
  }

  Map get map {
    return {
      "data": {
        "id": id,
        "name": name,
        "email": email,
        "avatar": imageUrl,
        "phone": phoneNumber,
        "address": address,
        "type": type,
        "approve": accountApproved ? 1 : 0,
        "phone_verified": phoneVerified ? 1 : 0,
        "trusted": trusted ? 1 : 0,
        "total_rating": totalRating,
      },
      "token": token,
    };
  }
}
