// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 3;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      id: fields[0] as int,
      senderId: fields[1] as int,
      receiverId: fields[2] as int,
      roomId: fields[3] as int,
      file: fields[5] as String,
      text: fields[4] as String,
      received: fields[7] as bool,
      removed: fields[6] as bool,
      edit: fields[8] as bool,
      seen: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.receiverId)
      ..writeByte(3)
      ..write(obj.roomId)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.file)
      ..writeByte(6)
      ..write(obj.removed)
      ..writeByte(7)
      ..write(obj.received)
      ..writeByte(8)
      ..write(obj.edit)
      ..writeByte(9)
      ..write(obj.seen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
