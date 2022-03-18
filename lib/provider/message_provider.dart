import 'package:flutter/material.dart';
import 'package:ichat/data/info.dart';
import 'package:ichat/database/messages_db.dart';
import '../database/boxes.dart';

class MessageProvider with ChangeNotifier {
  Iterable<Message> getMessages(int roomId) {
    return messagesBox.values.where((element) => element.roomId == roomId).toList().reversed;
  }

  Message getLastMessages(int roomId) {
    return messagesBox.values.lastWhere((element) => element.roomId == roomId, orElse: () {
      return Message(
        id: 0,
        senderId: 0,
        receiverId: 0,
        roomId: 0,
        file: '',
        text: '',
        received: false,
        removed: false,
        edit: false,
        seen: false,
      );
    });
  }

  int getCountMessages(int roomId) {
    return messagesBox.values.where((element) => element.roomId == roomId).length;
  }

  int getCountNotSeen(int roomId) {
    return messagesBox.values.where((element) => element.roomId == roomId && element.receiverId == getMyInfo().id && element.seen == false).length;
  }

  Future<void> addMessage(Message message) async {
    await messagesBox.add(message);
    notifyListeners();
  }

  Future<void> setReceived(int roomId) async {
    for (var element in messagesBox.values) {
      if (element.roomId == roomId && element.received == false) {
        element.received = true;
        await element.save();
        break;
      }
    }
    notifyListeners();
  }

  Future<void> setSeen(int roomId) async {
    for (var element in messagesBox.values) {
      if (element.roomId == roomId && element.seen == false) {
        element.received = true;
        element.seen = true;
        await element.save();
        break;
      }
    }
    notifyListeners();
  }

  Future<void> removeMessage(int id) async {
    for (var element in messagesBox.values) {
      if (element.id == id) {
        await element.delete();
        break;
      }
    }
    notifyListeners();
  }

  Future<void> clearMessages() async {
    await messagesBox.clear();
    notifyListeners();
  }
}
