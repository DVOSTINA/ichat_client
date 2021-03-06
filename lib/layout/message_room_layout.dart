import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ichat/data/server.dart';
import 'package:ichat/provider/user_provider.dart';
import 'package:ichat/server/server_socket.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data.dart';
import '../data/info.dart';
import '../database/messages_db.dart';
import '../database/users_db.dart';
import '../provider/message_provider.dart';
import '../styles/theme_data.dart';
import '../widget/message_layout/message_header_widget.dart';
import '../widget/message_layout/message_item_widget.dart';
import '../widget/message_layout/message_jump_to_end_widget.dart';
import '../widget/message_layout/message_sender_widget.dart';

class MessageRoomLayout extends StatefulWidget {
  const MessageRoomLayout({Key? key}) : super(key: key);

  static const String pageId = "MessageUserLayout";

  @override
  State<MessageRoomLayout> createState() => _MessageRoomLayoutState();
}

class _MessageRoomLayoutState extends State<MessageRoomLayout> {
  TextEditingController textController = TextEditingController();

  ScrollController scrollController = ScrollController();

  late Map<int, bool> menuStatus = {};

  String textInput = "";
  bool isReady = false;
  bool isAttach = false;

  bool isDown = true;

  int lastCountMessage = 0;
  int page = 0;

  late int roomId;
  late int receiverId;

  late User user;
  late Iterable<Message> messages;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels == 0) {
        setState(() {
          isDown = true;
        });
      } else if (scrollController.position.pixels != 0 && isDown) {
        setState(() {
          isDown = false;
        });
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (scrollController.positions.isNotEmpty) {
        scrollController.jumpTo(0);
      }
    });
  }

  @override
  void didChangeDependencies() {
    //! Get Argument
    receiverId = getArguments(context, "receiverId");
    roomId = getArguments(context, "roomId");

    user = context.watch<UserProvider>().getUser(receiverId);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //! Watch Provider Message
    messages = context.watch<MessageProvider>().getMessages(roomId);
    Message lastMessages = context.watch<MessageProvider>().getLastMessages(roomId);

    if (messages.isNotEmpty && lastMessages.seen == false) {
      socketManager.socket.emit("seenUserMessage", {"senderId": receiverId, "roomId": roomId});
    }

    return Scaffold(
      body: Stack(
        children: [
          //! List Messages
          Container(
            padding: EdgeInsets.only(
              top: 80 + getSizeSafe(context).top,
              bottom: isAttach ? 120 : 60 + getSizeSafe(context).bottom,
            ),
            color: getColorTheme(context).secondary,
            child: Stack(
              children: [
                //! List
                Visibility(
                  visible: messages.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      "???????? ???????? ???? ???????? ??????",
                      style: getTextTheme(context).headline2,
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: messages.length,
                    itemBuilder: itemMessage,
                  ),
                ),
                //! Jump to End
                MessageJumpToEndWidget(
                  visible: !isDown,
                  onTap: () {
                    //! Scroll Jump to End
                    scrollController.jumpTo(0);
                  },
                ),
              ],
            ),
          ),
          //! Header Info
          Align(
            alignment: Alignment.topCenter,
            child: MessageHeaderWidget(
              id: receiverId,
              isUser: true,
              isOnline: lastView(context.watch<UserProvider>().getUser(receiverId).onlineAt)[1],
              title: user.getFullName(),
              description: user.bio,
              profile: getIpProfile + user.profile,
              onBack: back,
              onProfile: profile,
            ),
          ),
          //! Send Tools
          Align(
            alignment: Alignment.bottomCenter,
            child: MessageSenderWidget(
              isAttach: isAttach,
              textController: textController,
              isReady: isReady,
              onChanged: (value) {
                setState(() {
                  textInput = value;
                  isReady = value.trim().isNotEmpty;
                });
              },
              onSend: () {
                sendUserMessage(receiverId, textController.text, "");
              },
              onDone: (value) {
                sendUserMessage(receiverId, textController.text, "");
              },
              onAttach: () {
                setState(() {
                  isAttach = !isAttach;
                });
              },
              onAttachFile: () async {
                // if (await Permission.storage.request().isGranted) {
                //   FilePickerResult? filePicker = await FilePicker.platform.pickFiles(withData: true);

                //   if (filePicker != null) {
                //     sendUserMessage(receiverId, 2, base64Encode(filePicker.files.first.bytes!.toList()));
                //   }
                // }
                setState(() {
                  isAttach = false;
                });
              },
              onAttachImage: () async {
                if (await Permission.storage.request().isGranted) {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 800,
                    maxHeight: 800,
                    imageQuality: 60,
                  );

                  if (file != null) {
                    sendUserMessage(receiverId, textController.text, base64Encode(await file.readAsBytes()));
                  }
                }
                setState(() {
                  isAttach = false;
                });
              },
              onAttachCamera: () async {
                if (await Permission.camera.request().isGranted) {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 800,
                    maxHeight: 800,
                    imageQuality: 60,
                  );

                  if (file != null) {
                    sendUserMessage(receiverId, textController.text, base64Encode(await file.readAsBytes()));
                  }
                }
                setState(() {
                  isAttach = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemMessage(BuildContext context, int index) {
    Message message = messages.elementAt(index);
    bool isSender = message.senderId == getMyInfo().id;

    if (!menuStatus.containsKey(message.id)) {
      menuStatus[message.id] = false;
    }

    return MessageItemWidget(
      isSender: isSender,
      id: message.id,
      text: message.text,
      file: message.file,
      isEdit: message.edit,
      isSeen: message.seen,
      isReceived: message.received,
      isMenuStatus: false,
      onMenu: () {
        setState(() {
          menuStatus[message.id] = menuStatus[message.id] != true;
        });
      },
      onRemove: () {
        setState(() {
          if (menuStatus.containsKey(message.id)) {
            menuStatus.remove(message.id);
            removeUserMessage(message.id);
          }
        });
      },
    );
  }

  void back() {
    Navigator.pop(context);
  }

  void profile() {}

  void sendUserMessage(int receiverId, String text, String file) async {
    socketManager.socket.emit(
      "newUserMessage",
      {
        "receiverId": receiverId,
        "text": text,
        "file": file,
      },
    );

    setState(() {
      textController.clear();
      isReady = false;
    });
  }

  void removeUserMessage(int id) {
    socketManager.socket.emit(
      "removeUserMessage",
      {
        "messageId": id,
      },
    );
  }
}
