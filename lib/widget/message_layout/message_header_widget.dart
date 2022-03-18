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
    required this.onProfile,
    required this.onBack,
    required this.isUser,
    required this.isOnline,
  }) : super(key: key);

  final int id;
  final String title;
  final String description;
  final String profile;

  final Function() onProfile;
  final Function() onBack;

  final bool isUser;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSizeScreenSafe(context).width,
      height: 80 + getSizeSafe(context).top,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 10 + getSizeSafe(context).top,
      ),
      decoration: BoxDecoration(
        color: getColorTheme(context).primary,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
            color: Color.fromARGB(10, 0, 0, 0),
          ),
        ],
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
                        style: getTextTheme(context).headline1?.copyWith(fontSize: 15),
                      ),
                      Visibility(
                        visible: description.isNotEmpty,
                        child: const SizedBox(height: 5),
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
                            style: getTextTheme(context).headline3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Profile
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ProfileWidget(
                    size: 60,
                    isOnline: true,
                    profileUrl: profile,
                    onlineColor: getColorTheme(context).tertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
