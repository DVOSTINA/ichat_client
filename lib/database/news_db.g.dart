// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 4;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      id: fields[0] as int,
      senderId: fields[1] as int,
      file: fields[3] as String,
      text: fields[2] as String,
      removed: fields[4] as bool,
      edit: fields[5] as bool,
      createAt: fields[6] as int,
      updateAt: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.removed)
      ..writeByte(5)
      ..write(obj.edit)
      ..writeByte(6)
      ..write(obj.createAt)
      ..writeByte(7)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
