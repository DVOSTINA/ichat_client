import 'package:hive_flutter/hive_flutter.dart';

part 'rooms_db.g.dart';

@HiveType(typeId: 2)
class Room extends HiveObject {
  Room({
    required this.id,
    required this.creatorId,
    required this.userId,
    required this.createAt,
    required this.updateAt,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late int creatorId;
  @HiveField(2)
  late int userId;
  @HiveField(3)
  late int createAt;
  @HiveField(4)
  late int updateAt;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: int.parse(json['id'].toString()),
      creatorId: int.parse(json['creatorId'].toString()),
      userId: int.parse(json['userId'].toString()),
      createAt: int.parse(json['create_at'].toString()),
      updateAt: int.parse(json['update_at'].toString()),
    );
  }
}
