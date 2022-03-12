import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ichat/database/groups_db.dart';
import 'package:ichat/provider/group_provider.dart';
import 'package:ichat/server/server_socket.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data.dart';
import '../data/info.dart';
import '../database/messages_db.dart';
import '../provider/message_provider.dart';
import '../provider/user_provider.dart';
import '../styles/theme_data.dart';
import '../widget/message_layout/message_header_widget.dart';
import '../widget/message_layout/message_item_widget.dart';
import '../widget/message_layout/message_jump_to_end_widget.dart';
import '../widget/message_layout/message_sender_widget.dart';

class MessageGroupLayout extends StatefulWidget {
  const MessageGroupLayout({Key? key}) : super(key: key);

  static const String pageId = "MessageGroupLayout";

  @override
  State<MessageGroupLayout> createState() => _MessageGroupLayoutState();
}

class _MessageGroupLayoutState extends State<MessageGroupLayout> {
  TextEditingController textController = TextEditingController();

  ScrollController scrollController = ScrollController();

  late Map<int, bool> menuStatus = {};

  String textInput = "";
  bool isReady = false;
  bool isAttach = false;

  bool isUp = false;
  bool isDown = true;

  int lastCountMessage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //! Scroll Listener
      scrollController.addListener(() {
        if (scrollController.position.atEdge && scrollController.position.pixels == 0) {
          setState(() {
            isUp = true;
            isDown = false;
          });
        } else if (scrollController.position.pixels != 0 && (isUp || isDown)) {
          setState(() {
            isUp = false;
            isDown = false;
          });
        } else if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
          setState(() {
            isDown = true;
            isUp = false;
          });
        }
      });
      //! Scroll Jump to End
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //! Set Arguments
    int receiverId = getArguments(context, 'id');
    bool isChannel = getArguments(context, 'isChannel');

    //! Watch Provider Message
    Iterable<Message> messages = context.watch<MessageProvider>().getMessages(receiverId);
    Group group = context.watch<GroupProvider>().getGroup(receiverId);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (lastCountMessage != messages.length) {
        //! Scroll Jump to End
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );

        lastCountMessage = messages.length;
      }
    });

    if (messages.isNotEmpty && messages.last.receiverId == getMyInfo().id && messages.last.seen == false) {
      socketManager.socket.emit("seenUserMessage", {"senderId": receiverId});
      context.read<MessageProvider>().setSeen(receiverId);
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: getColorTheme(context).primary,
          child: Column(
            children: [
              //! Header Info
              MessageHeaderWidget(
                id: receiverId,
                isUser: false,
                isOnline: lastView(context.watch<UserProvider>().getUser(receiverId).onlineAt)[1],
                title: group.title,
                description: group.description,
                profile: "",
                onBack: () {
                  Navigator.pop(context);
                },
                onMenu: () {},
              ),
              //! List Messages
              Expanded(
                child: Stack(
                  children: [
                    //! List
                    ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
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
                          isMenuStatus: menuStatus[message.id],
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
                      },
                    ),
                    //! Jump to End
                    MessageJumpToEndWidget(
                      visible: !isDown,
                      onTap: () {
                        //! Scroll Jump to End
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      },
                    ),
                  ],
                ),
              ),
              //! Send Tools
              Visibility(
                visible: !isChannel,
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
                    sendGroupMessage(receiverId, 0, textController.text);
                  },
                  onDone: (value) {
                    sendGroupMessage(receiverId, 0, textController.text);
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
                        sendGroupMessage(receiverId, 1, base64Encode(await file.readAsBytes()));
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
                        sendGroupMessage(receiverId, 1, base64Encode(await file.readAsBytes()));
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
        ),
      ),
    );
  }

  void sendGroupMessage(int receiverId, int messageType, String messageBody) async {
    socketManager.socket.emit(
      "newGroupMessage",
      {
        "receiverId": receiverId,
        "messageType": messageType,
        "body": messageBody,
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
