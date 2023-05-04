// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 2;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product()
      ..approved = fields[0] as bool
      ..usedProduct = fields[1] as bool
      ..id = fields[2] as int
      ..quantity = fields[3] as int
      ..originalPrice = fields[4] as double
      ..totalRating = fields[5] as double
      ..priceAfterOffer = fields[6] as double
      ..arName = fields[7] as String
      ..enName = fields[8] as String
      ..thumbnailImage = fields[9] as String
      ..arOriginCountry = fields[10] as String
      ..enOriginCountry = fields[11] as String
      ..guaranteeCompany = fields[12] as String
      ..arGuaranteePeriod = fields[13] as String
      ..enGuaranteePeriod = fields[14] as String
      ..imagesUrls = (fields[15] as List).cast<dynamic>()
      ..dateAdded = fields[16] as DateTime
      ..offerPercentage = fields[17] as int?
      ..compatibleCars = (fields[18] as Map).cast<dynamic, dynamic>()
      ..firstReview = fields[19] as StoreReview?
      ..dealer = fields[20] as User
      ..categoryId = fields[21] as int;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.approved)
      ..writeByte(1)
      ..write(obj.usedProduct)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.originalPrice)
      ..writeByte(5)
      ..write(obj.totalRating)
      ..writeByte(6)
      ..write(obj.priceAfterOffer)
      ..writeByte(7)
      ..write(obj.arName)
      ..writeByte(8)
      ..write(obj.enName)
      ..writeByte(9)
      ..write(obj.thumbnailImage)
      ..writeByte(10)
      ..write(obj.arOriginCountry)
      ..writeByte(11)
      ..write(obj.enOriginCountry)
      ..writeByte(12)
      ..write(obj.guaranteeCompany)
      ..writeByte(13)
      ..write(obj.arGuaranteePeriod)
      ..writeByte(14)
      ..write(obj.enGuaranteePeriod)
      ..writeByte(15)
      ..write(obj.imagesUrls)
      ..writeByte(16)
      ..write(obj.dateAdded)
      ..writeByte(17)
      ..write(obj.offerPercentage)
      ..writeByte(18)
      ..write(obj.compatibleCars)
      ..writeByte(19)
      ..write(obj.firstReview)
      ..writeByte(20)
      ..write(obj.dealer)
      ..writeByte(21)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
