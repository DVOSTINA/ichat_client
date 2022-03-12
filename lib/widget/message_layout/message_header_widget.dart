import 'package:flutter/material.dart';
import 'package:ichat/data.dart';

import '../../styles/theme_data.dart';
import '../profile_widget.dart';

class MessageHeaderWidget extends StatelessWidget {
  const MessageHeaderWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.profile,
    required this.onMenu,
    required this.onBack,
    required this.isUser,
    required this.isOnline,
  }) : super(key: key);

  final int id;
  final String title;
  final String description;
  final String profile;

  final Function() onMenu;
  final Function() onBack;

  final bool isUser;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSizeScreenSafe(context).width,
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: getColorTheme(context).secondary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! Button Back
          GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: onBack,
          ),
          //! Button Profile
          Expanded(
            child: Row(
              children: [
                //! Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //! Title
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: getTextTheme(context).headline4?.copyWith(fontSize: 15),
                      ),
                      Visibility(
                        visible: description.isNotEmpty,
                        child: const Spacer(),
                      ),
                      //! Description
                      Visibility(
                        visible: description.isNotEmpty,
                        child: Opacity(
                          opacity: 0.5,
                          child: Text(
                            description,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: getTextTheme(context).headline4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Profile
                ProfileWidget(
                  size: 50,
                  isOnline: true,
                  profileUrl: profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
