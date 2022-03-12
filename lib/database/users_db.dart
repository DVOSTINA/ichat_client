import 'package:hive_flutter/hive_flutter.dart';

part 'users_db.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.profile,
    required this.bio,
    required this.grade,
    required this.major,
    required this.onlineAt,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late String firstName;
  @HiveField(2)
  late String lastName;
  @HiveField(3)
  late String username;
  @HiveField(4)
  late String profile;
  @HiveField(5)
  late String bio;
  @HiveField(6)
  late String grade;
  @HiveField(7)
  late String major;
  @HiveField(8)
  late int onlineAt;

  String getFullName() {
    return firstName + " " + lastName;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstname'].toString(),
      lastName: json['lastname'].toString(),
      username: json['username'].toString(),
      profile: json['profile'].toString(),
      bio: json['bio'].toString(),
      grade: json['grade'].toString(),
      major: json['major'].toString(),
      onlineAt: json['online_at'],
    );
  }
}
