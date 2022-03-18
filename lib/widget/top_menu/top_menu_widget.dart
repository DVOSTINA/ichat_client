import 'package:flutter/material.dart';
import 'package:ichat/data.dart';
import 'package:ichat/layout/notify_layout.dart';
import 'package:ichat/layout/school_layout.dart';
import 'package:ichat/provider/config_provider.dart';
import 'package:ichat/provider/news_provider.dart';
import 'package:provider/provider.dart';

import '../../styles/theme_data.dart';
import 'top_menu_button_widget.dart';

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({
    Key? key,
    required this.title,
    this.notifyCount = 0,
  }) : super(key: key);

  final String title;
  final int notifyCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorTheme(context).primary,
      padding: EdgeInsets.only(
        bottom: 20,
        left: 30,
        right: 30,
        top: 20 + getSizeSafe(context).top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! Notify
          MenuButtonWidget(
            icon: Icons.notifications_outlined,
            count: context.watch<NewsProvider>().getCountNews(),
            onTap: () {
              Navigator.pushNamed(context, NotifyLayout.pageId);
            },
          ),
          //! Title
          Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: getTextTheme(context).headline1,
              ),
              Visibility(
                visible: context.watch<ConfigProvider>().getSocketStatus() == false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "در حال اتصال به سرور",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: getTextTheme(context).bodyText1,
                  ),
                ),
              ),
            ],
          ),
          //! School
          MenuButtonWidget(
            icon: Icons.school_outlined,
            count: 0,
            onTap: () {
              Navigator.pushNamed(context, SchoolLayout.pageId);
            },
          ),
        ],
      ),
    );
  }
}
