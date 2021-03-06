// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      username: fields[3] as String,
      profile: fields[4] as String,
      bio: fields[5] as String,
      grade: fields[6] as String,
      major: fields[7] as String,
      lastNotify: fields[8] as int,
      onlineAt: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.profile)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.grade)
      ..writeByte(7)
      ..write(obj.major)
      ..writeByte(8)
      ..write(obj.lastNotify)
      ..writeByte(9)
      ..write(obj.onlineAt);
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
