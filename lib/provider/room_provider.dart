import 'package:flutter/material.dart';
import 'package:ichat/database/rooms_db.dart';

import '../database/boxes.dart';

class RoomProvider with ChangeNotifier {
  Iterable<Room> getAllRoom() {
    return roomsBox.values;
  }

  Room getRoom(int index) {
    return roomsBox.values.elementAt(index);
  }

  Room getRoomByUserId(int userId) {
    return roomsBox.values.firstWhere(
      (element) => element.creatorId == userId || element.userId == userId,
      orElse: () {
        return Room(
          id: 0,
          creatorId: 0,
          userId: 0,
          createAt: 0,
          updateAt: 0,
        );
      },
    );
  }

  int getCountRoom() {
    return roomsBox.values.length;
  }

  Future<void> addRoom(Room room) async {
    await roomsBox.add(room);
    notifyListeners();
  }

  Future<void> clearRoom() async {
    await roomsBox.clear();
    notifyListeners();
  }
}
