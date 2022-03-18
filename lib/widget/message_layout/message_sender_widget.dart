import 'package:flutter/material.dart';
import 'package:ichat/data.dart';

import '../../styles/theme_data.dart';

class MessageSenderWidget extends StatelessWidget {
  const MessageSenderWidget({
    Key? key,
    required this.isAttach,
    required this.isReady,
    required this.onSend,
    required this.onAttach,
    required this.onAttachFile,
    required this.onAttachImage,
    required this.onAttachCamera,
    required this.onChanged,
    required this.textController,
    this.onDone,
  }) : super(key: key);

  final bool isAttach;
  final bool isReady;

  final Function() onSend;
  final Function(String)? onDone;
  final Function() onAttach;
  final Function() onAttachFile;
  final Function() onAttachImage;
  final Function() onAttachCamera;
  final Function(String) onChanged;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 5 + getSizeSafe(context).bottom,
      ),
      height: isAttach ? 120 : 60 + getSizeSafe(context).bottom,
      decoration: BoxDecoration(
        color: getColorTheme(context).primary,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 0,
            color: Color.fromARGB(30, 0, 0, 0),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          //! Input
          Row(
            children: [
              //! Attach
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: getColorTheme(context).onPrimary,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Color.fromARGB(30, 0, 0, 0),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.attach_file,
                    size: 18,
                  ),
                ),
                onTap: onAttach,
              ),
              //! Input Text
              Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: getColorTheme(context).onPrimary,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Color.fromARGB(30, 0, 0, 0),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: TextField(
                      controller: textController,
                      textDirection: TextDirection.rtl,
                      cursorColor: getColorTheme(context).onSecondary,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        isCollapsed: true,
                        hintText: 'پیام خود را بنویسید',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                      onChanged: onChanged,
                      onSubmitted: onDone,
                    ),
                  ),
                ),
              ),
              //! Button Send
              Visibility(
                visible: isReady,
                child: GestureDetector(
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: getColorTheme(context).surface,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                          color: Color.fromARGB(30, 0, 0, 0),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.send,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  onTap: onSend,
                ),
              ),
            ],
          ),
          //! Attach
          Visibility(
            visible: isAttach,
            child: Row(
              children: [
                //! File
                SenderMenuAttackButtonWidget(
                  icon: Icons.file_copy_outlined,
                  onTap: onAttach,
                  backgroundColor: const Color(0xFFF14339),
                ),
                //! Gallery
                SenderMenuAttackButtonWidget(
                  icon: Icons.image_outlined,
                  onTap: onAttachImage,
                  backgroundColor: const Color(0xFF2268FF),
                ),
                //! Camera
                SenderMenuAttackButtonWidget(
                  icon: Icons.camera_alt_outlined,
                  onTap: onAttachCamera,
                  backgroundColor: const Color(0xFF39A84A),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SenderMenuAttackButtonWidget extends StatelessWidget {
  const SenderMenuAttackButtonWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color.fromARGB(30, 0, 0, 0),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
