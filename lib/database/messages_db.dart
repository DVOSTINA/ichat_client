import 'package:hive_flutter/hive_flutter.dart';

part 'messages_db.g.dart';

@HiveType(typeId: 3)
class Message extends HiveObject {
  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.roomId,
    required this.file,
    required this.text,
    required this.received,
    required this.removed,
    required this.edit,
    required this.seen,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late int senderId;
  @HiveField(2)
  late int receiverId;
  @HiveField(3)
  late int roomId;
  @HiveField(4)
  late String text;
  @HiveField(5)
  late String file;
  @HiveField(6)
  late bool removed;
  @HiveField(7)
  late bool received;
  @HiveField(8)
  late bool edit;
  @HiveField(9)
  late bool seen;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: int.parse(json['id'].toString()),
      senderId: int.parse(json['senderId'].toString()),
      receiverId: int.parse(json['receiverId'].toString()),
      roomId: int.parse(json['roomId'].toString()),
      text: json['text'].toString(),
      file: json['file'].toString(),
      removed: json['removed'],
      received: json['received'],
      edit: json['edit'],
      seen: json['seen'],
    );
  }
}
