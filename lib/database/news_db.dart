import 'package:hive_flutter/hive_flutter.dart';

part 'news_db.g.dart';

@HiveType(typeId: 4)
class News extends HiveObject {
  News({
    required this.id,
    required this.senderId,
    required this.file,
    required this.text,
    required this.removed,
    required this.edit,
    required this.createAt,
    required this.updateAt,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late int senderId;
  @HiveField(2)
  late String text;
  @HiveField(3)
  late String file;
  @HiveField(4)
  late bool removed;
  @HiveField(5)
  late bool edit;
  @HiveField(6)
  late int createAt;
  @HiveField(7)
  late int updateAt;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: int.parse(json['id'].toString()),
      senderId: int.parse(json['senderId'].toString()),
      text: json['text'].toString(),
      file: json['file'].toString(),
      removed: json['removed'],
      edit: json['edit'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
    );
  }
}
