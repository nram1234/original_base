import 'package:hive/hive.dart';
//------------------------------
part 'year_of_manufacture.g.dart';
//--------------------------------

@HiveType(typeId: 12)
class CarYearOfManufacture {
  @HiveField(1)
  late final int id;

  @HiveField(2)
  late final int year;

  /// default constructor to make
  /// hive_generator runs successfully.
  CarYearOfManufacture();

  CarYearOfManufacture.fromJson(Map map) {
    id = map["id"];
    year = int.parse(map["year"]);
  }

  Map get map {
    return {
      "id": id,
      "year": "$year",
    };
  }
}
