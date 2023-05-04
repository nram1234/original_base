// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeBannerAdapter extends TypeAdapter<HomeBanner> {
  @override
  final int typeId = 13;

  @override
  HomeBanner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeBanner()
      ..id = fields[1] as int
      ..imageUrl = fields[2] as String
      ..title = (fields[3] as Map).cast<dynamic, dynamic>()
      ..description = (fields[4] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, HomeBanner obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeBannerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
