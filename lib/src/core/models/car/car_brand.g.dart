// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_brand.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarBrandAdapter extends TypeAdapter<CarBrand> {
  @override
  final int typeId = 9;

  @override
  CarBrand read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarBrand()
      ..id = fields[1] as int
      ..thumbnailUrl = fields[2] as String
      ..name = (fields[3] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, CarBrand obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.thumbnailUrl)
      ..writeByte(3)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarBrandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
