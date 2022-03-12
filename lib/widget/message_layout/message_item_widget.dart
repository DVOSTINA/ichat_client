import 'package:flutter/material.dart';
import 'package:ichat/data.dart';
import 'package:provider/provider.dart';

import '../../data/server.dart';
import '../../provider/config_provider.dart';
import '../../styles/theme_data.dart';
import 'message_item_tools_widget.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    Key? key,
    required this.id,
    required this.text,
    required this.file,
    required this.onMenu,
    this.isSender = false,
    this.isEdit = false,
    this.isSeen = false,
    this.isReceived = false,
    this.isMenuStatus = false,
    this.onEdit,
    this.onInfo,
    this.onRemove,
  }) : super(key: key);

  final int id;
  final String text;
  final String file;

  final bool? isSender;
  final bool? isSeen;
  final bool? isReceived;
  final bool? isEdit;
  final bool? isMenuStatus;

  final Function() onMenu;
  final Function()? onEdit;
  final Function()? onInfo;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: isSender! ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Visibility(
            visible: isMenuStatus!,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: isSender!,
                  child: MessageItemToolsWidget(
                    icon: Icons.edit_outlined,
                    onTap: onEdit,
                  ),
                ),
                MessageItemToolsWidget(
                  icon: Icons.info_outline,
                  onTap: onInfo,
                ),
                Visibility(
                  visible: isSender!,
                  child: MessageItemToolsWidget(
                    icon: Icons.delete_outline,
                    onTap: onRemove,
                  ),
                ),
              ],
            ),
          ),
          //! Body
          GestureDetector(
            onLongPress: onMenu,
            child: Container(
              constraints: BoxConstraints(maxWidth: getSizeScreenSafe(context).width - 100),
              margin: EdgeInsets.only(left: isSender! ? 5 : 0, right: isSender! ? 0 : 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.watch<ConfigProvider>().getDarkTheme() ? getColorTheme(context).onPrimary : getColorTheme(context).tertiary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //! Body Data
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: getBody(context),
                  ),
                  //! Body Info
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isSender!,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              isReceived! ? Icons.done_all_outlined : Icons.check,
                              color: isSeen! ? getColorTheme(context).onSurface : getColorTheme(context).onTertiary,
                              size: 15,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isEdit!,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.edit_outlined,
                              color: getColorTheme(context).onTertiary,
                              size: 15,
                            ),
                          ),
                        ),
                        Text(
                          "12:54 AM",
                          style: getTextTheme(context).bodyText1?.copyWith(fontFamily: 'OpenSans'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: file.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            constraints: const BoxConstraints(
              minHeight: 300,
              minWidth: 300,
              maxHeight: 300,
            ),
            color: getColorTheme(context).onSecondary.withOpacity(0.3),
            child: Image.network(
              getIpFile + file,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
        ),
        Text(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: getTextTheme(context).bodyText1,
        ),
      ],
    );
  }
}
