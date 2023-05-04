// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_review.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreReviewAdapter extends TypeAdapter<StoreReview> {
  @override
  final int typeId = 6;

  @override
  StoreReview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreReview()
      ..id = fields[1] as int
      ..rating = fields[2] as double
      ..comment = fields[3] as String
      ..owner = fields[4] as User
      ..dateAdded = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, StoreReview obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.owner)
      ..writeByte(5)
      ..write(obj.dateAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreReviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
