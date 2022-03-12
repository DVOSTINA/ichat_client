import 'package:hive_flutter/hive_flutter.dart';

part 'groups_db.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject {
  Group({
    required this.id,
    required this.title,
    required this.description,
    required this.adminId,
    required this.type,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late int adminId;
  @HiveField(4)
  late bool type;

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: int.parse(json['id'].toString()),
      title: json['title'].toString(),
      description: json['description'].toString(),
      adminId: int.parse(json['adminId'].toString()),
      type: json['type'].toString() == '1' ? true : false,
    );
  }
}
