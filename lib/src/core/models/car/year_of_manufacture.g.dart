// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_of_manufacture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarYearOfManufactureAdapter extends TypeAdapter<CarYearOfManufacture> {
  @override
  final int typeId = 12;

  @override
  CarYearOfManufacture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarYearOfManufacture()
      ..id = fields[1] as int
      ..year = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, CarYearOfManufacture obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarYearOfManufactureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
