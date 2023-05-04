// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_engine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarEngineAdapter extends TypeAdapter<CarEngine> {
  @override
  final int typeId = 10;

  @override
  CarEngine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarEngine()
      ..id = fields[1] as int
      ..name = (fields[2] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, CarEngine obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarEngineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
