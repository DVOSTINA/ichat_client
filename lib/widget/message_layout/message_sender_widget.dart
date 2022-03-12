import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(5),
      height: 60,
      decoration: BoxDecoration(
        color: getColorTheme(context).secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: getColorTheme(context).onSecondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.attach_file,
                size: 18,
                color: Colors.white,
              ),
            ),
            onTap: onAttach,
          ),
          Visibility(
            visible: false,
            child: GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: getColorTheme(context).onSecondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.file_copy_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onTap: onAttach,
            ),
          ),
          Visibility(
            visible: isAttach,
            child: GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: getColorTheme(context).onSecondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.image_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onTap: onAttachImage,
            ),
          ),
          Visibility(
            visible: isAttach,
            child: GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: getColorTheme(context).onSecondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onTap: onAttachCamera,
            ),
          ),
          Visibility(
            visible: !isAttach,
            child: Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: getColorTheme(context).onSecondary,
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
          ),
          Visibility(
            visible: !isAttach && isReady,
            child: GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: getColorTheme(context).surface,
                  shape: BoxShape.circle,
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
    );
  }
}
