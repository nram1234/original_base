// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..accountApproved = fields[1] as bool
      ..phoneVerified = fields[2] as bool
      ..id = fields[3] as int
      ..name = fields[4] as String
      ..email = fields[5] as String
      ..imageUrl = fields[6] as String
      ..phoneNumber = fields[7] as String
      ..address = fields[8] as String
      ..type = fields[9] as String
      ..token = fields[10] as String
      ..totalRating = fields[11] as double
      ..trusted = fields[12] as bool;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.accountApproved)
      ..writeByte(2)
      ..write(obj.phoneVerified)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.totalRating)
      ..writeByte(12)
      ..write(obj.trusted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
