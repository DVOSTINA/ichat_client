import 'package:flutter/material.dart';
import 'package:ichat/database/rooms_db.dart';
import 'package:ichat/database/users_db.dart';
import 'package:ichat/provider/config_provider.dart';
import 'package:ichat/provider/news_provider.dart';
import 'package:ichat/provider/room_provider.dart';
import 'package:ichat/provider/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../data/info.dart';
import '../data/server.dart';
import '../database/messages_db.dart';
import '../database/news_db.dart';
import '../provider/message_provider.dart';
import 'server_api.dart';

class SocketManager {
  late Socket socket;

  SocketManager() {
    socket = io(
      getIpSocket,
      OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'username': getMyInfo().username,
        'password': getMyPassword(),
        'id': getMyInfo().id.toString(),
      }).build(),
    );
  }

  void dispose() {
    socket.dispose();
  }

  void socketListener(BuildContext context) {
    socket.onConnect((data) async {
      debugPrint("onConnect");

      await context.read<RoomProvider>().clearRoom();
      await context.read<NewsProvider>().clearNews();
      await context.read<MessageProvider>().clearMessages();
      await context.read<UserProvider>().clearUsers();

      //! Get Users
      CustomResponse responseGetUsers = await serverApi.getUsers();
      for (var user in responseGetUsers.responsedata["data"]["users"]) {
        await context.read<UserProvider>().addUser(User.fromJson(user));
      }

      //! Get Room And limit 10 Messages
      CustomResponse responseGetRooms = await serverApi.getRoom();
      for (var room in responseGetRooms.responsedata["data"]["rooms"]) {
        for (var message in room["messages"]) {
          await context.read<MessageProvider>().addMessage(Message.fromJson(message));
        }
        await context.read<RoomProvider>().addRoom(Room.fromJson(room));
      }

      //! Get News
      CustomResponse responseGetNews = await serverApi.getNews();
      for (var news in responseGetNews.responsedata["data"]["news"]) {
        await context.read<NewsProvider>().addNews(News.fromJson(news));
      }

      //! Set Online
      context.read<ConfigProvider>().setSocketStatus();
    });

    socket.onDisconnect((data) {
      debugPrint("onDisconnect");

      //! Set Offline
      context.read<ConfigProvider>().setSocketStatus();
    });

    socket.on("getData", (data) async {
      debugPrint("getData");

      //! Get Users Online At
      for (var user in data["onlineAt"]) {
        await context.read<UserProvider>().setOnlineAt(
              int.parse(user["id"].toString()),
              int.parse(user["online_at"].toString()),
            );
      }

      //! get New Messages
      for (var item in data['newMessage']) {
        Message message = Message.fromJson(item);
        message.received = true;
        message.seen = true;

        await context.read<MessageProvider>().addMessage(message);
      }

      //! get Removed Messages
      for (var item in data['removedMessage']) {
        await context.read<MessageProvider>().removeMessage(int.parse(item["messageId"].toString()));
      }
    });

    socket.on("changeOnlineAt", (data) async {
      debugPrint("changeOnlineAt");

      await context.read<UserProvider>().setOnlineAt(
            int.parse(data["id"].toString()),
            int.parse(data["online_at"].toString()),
          );
    });

    socket.on("receivedMessage", (data) async {
      debugPrint("ReceivedMessages");

      await context.read<MessageProvider>().setReceived(data["messageId"]);
    });

    socket.on("newRoom", (data) {
      debugPrint("newRoom");

      Room room = Room.fromJson(data);

      context.read<RoomProvider>().addRoom(room);
    });

    socket.on("newUserMessage", (data) async {
      debugPrint("NewUserMessage");

      Message message = Message.fromJson(data);

      await context.read<MessageProvider>().addMessage(message);

      if (getMyInfo().id == message.receiverId) {
        createNotify(message.id, "پیام جدید", message.text);
      }
    });

    socket.on("removeUserMessage", (data) async {
      debugPrint("RemoveUserMessage");

      int messageId = data["messageId"];

      await context.read<MessageProvider>().removeMessage(messageId);
    });

    socket.on("seenUserMessage", (data) async {
      debugPrint("SeenUserMessage");

      // await context.read<MessageProvider>().setSeen(int.parse(data["messageId"].toString()));
    });

    socket.on("getNews", (data) async {
      debugPrint("getNews");

      News news = News.fromJson(data);

      await context.read<NewsProvider>().addNews(news);
    });
  }
}

late SocketManager socketManager;
