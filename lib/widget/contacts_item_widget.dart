import 'package:flutter/material.dart';

import '../styles/theme_data.dart';
import 'profile_widget.dart';

class ContactsItemWidget extends StatelessWidget {
  const ContactsItemWidget({
    Key? key,
    required this.title,
    this.text,
    this.profileUrl = "",
    this.isUser = true,
    this.isChannel = false,
    this.lastView = "",
    this.countMessage = 0,
    this.online = false,
    this.onTap,
  }) : super(key: key);

  final bool isUser;

  final String title;
  final String? text;
  final String profileUrl;
  final String? lastView;
  final bool? isChannel;
  final int? countMessage;
  final bool online;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: getColorTheme(context).primary,
        ),
        child: Row(
          children: [
            //! Left Side
            SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Info Icon
                  Opacity(
                    opacity: 0.7,
                    child: Visibility(
                      visible: isUser == false,
                      replacement: Text(
                        lastView!,
                        textDirection: TextDirection.rtl,
                        style: getTextTheme(context).bodyText1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          isChannel! ? Icons.notifications : Icons.group,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  //! Count New Message
                  Visibility(
                    visible: countMessage! > 0 ? true : false,
                    replacement: const SizedBox(
                      height: 20,
                    ),
                    child: Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: getColorTheme(context).surface,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          countMessage! >= 99 ? "99+" : countMessage.toString(),
                          style: getTextTheme(context).headline4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //! Info Side
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: getTextTheme(context).headline1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      text!,
                      textAlign: TextAlign.right,
                      style: getTextTheme(context).bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            //! Profile
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ProfileWidget(
                isOnline: true,
                onlineColor: darkBlueColorLight,
                size: 80,
                profileUrl: profileUrl,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
