import 'package:flutter/material.dart';

import '../styles/theme_data.dart';
import 'profile_widget.dart';

class RoomsItemWidget extends StatelessWidget {
  const RoomsItemWidget({
    Key? key,
    required this.title,
    this.lastMessage = '',
    this.profile = '',
    this.lastView = '',
    this.countMessage = 0,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String lastMessage;
  final String profile;
  final String lastView;
  final int countMessage;
  final bool isOnline;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
              color: Color.fromARGB(10, 0, 0, 0),
            ),
          ],
          color: getColorTheme(context).primary,
        ),
        child: Row(
          children: [
            //! Info
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Last View
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      lastView,
                      textDirection: TextDirection.rtl,
                      style: getTextTheme(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            //! Data
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: getTextTheme(context).headline1?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: lastMessage.isEmpty ? 0 : 5,
                    ),
                    Visibility(
                      visible: lastMessage.isNotEmpty,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          lastMessage,
                          textAlign: TextAlign.right,
                          style: getTextTheme(context).bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //! Profile
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ProfileWidget(
                isOnline: isOnline,
                onlineColor: getColorTheme(context).tertiary,
                profileUrl: profile,
                size: 60,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
