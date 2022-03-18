import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data.dart';
import '../../data/server.dart';
import '../../database/news_db.dart';
import '../../database/users_db.dart';
import '../../styles/theme_data.dart';
import '../profile_widget.dart';

class NotifyItemWidget extends StatelessWidget {
  const NotifyItemWidget({
    Key? key,
    required this.user,
    required this.itemNews,
  }) : super(key: key);

  final User user;
  final News itemNews;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //! Info
          Row(
            textDirection: TextDirection.rtl,
            children: [
              ProfileWidget(
                isOnline: lastView(user.onlineAt)[1],
                onlineColor: getColorTheme(context).tertiary,
                profileUrl: getIpProfile + user.profile,
                size: 60,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    user.getFullName(),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 5),
                  Visibility(
                    visible: user.bio.isNotEmpty,
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        user.bio,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //! Data
          Container(
            width: getSizeScreenSafe(context).width,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: getColorTheme(context).onPrimary,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: Color.fromARGB(10, 0, 0, 0),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //! File
                Visibility(
                  visible: itemNews.file.isNotEmpty,
                  child: Container(
                    width: getSizeScreenSafe(context).width,
                    height: 250,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ExtendedImage.network(
                      getIpProfile + itemNews.file,
                      fit: BoxFit.cover,
                      cache: true,
                      clearMemoryCacheWhenDispose: false,
                      clearMemoryCacheIfFailed: false,
                      loadStateChanged: (ExtendedImageState state) {
                        if (state.extendedImageLoadState == LoadState.loading || state.extendedImageLoadState == LoadState.failed) {
                          return const Icon(
                            Icons.person,
                          );
                        } else {
                          return ExtendedRawImage(
                            image: state.extendedImageInfo?.image,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
                ),
                //! Text
                Linkify(
                  text: itemNews.text,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    }
                  },
                ),
                //! Time
                Opacity(
                  opacity: 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      getTimeByTimeStamp(itemNews.createAt),
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTimeByTimeStamp(int timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');

    return year + "/" + month + "/" + day + " - " + hour + ":" + minute + ":" + second;
  }
}
