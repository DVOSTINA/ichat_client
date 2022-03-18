import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ichat/data.dart';
import 'package:ichat/provider/config_provider.dart';
import 'package:ichat/provider/news_provider.dart';
import 'package:ichat/provider/user_provider.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:ichat/widget/notify/notify_header_widget.dart';
import 'package:provider/provider.dart';

import '../database/news_db.dart';
import '../database/users_db.dart';
import '../widget/notify/notify_item_widget.dart';

class NotifyLayout extends StatefulWidget {
  const NotifyLayout({Key? key}) : super(key: key);

  static const String pageId = "NotifyLayout";

  @override
  State<NotifyLayout> createState() => _NotifyLayoutState();
}

class _NotifyLayoutState extends State<NotifyLayout> {
  ScrollController scrollController = ScrollController();

  late Iterable<News> news;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (scrollController.positions.isNotEmpty) {
        scrollController.jumpTo(0);
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    News news = context.watch<NewsProvider>().getLastNews();

    await context.watch<ConfigProvider>().setLastNotify(news.createAt);
  }

  @override
  Widget build(BuildContext context) {
    news = context.watch<NewsProvider>().getAllNews();

    return Scaffold(
      body: Stack(
        children: [
          //! List News
          Align(
            alignment: Alignment.center,
            child: Container(
              height: getSizeScreen(context).height,
              color: getColorTheme(context).secondary,
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                controller: scrollController,
                itemCount: news.length,
                padding: EdgeInsets.only(
                  top: 5 + 50 + getSizeSafe(context).top,
                  bottom: 5 + getSizeSafe(context).bottom,
                ),
                itemBuilder: itemNews,
              ),
            ),
          ),
          //! Header
          Align(
            alignment: Alignment.topCenter,
            child: NotifyHeaderWidget(
              title: 'اخبار دانشکده',
              icon: Icons.arrow_back,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemNews(BuildContext context, int index) {
    News itemNews = news.elementAt(index);

    User user = context.watch<UserProvider>().getUser(itemNews.senderId);

    return NotifyItemWidget(
      user: user,
      itemNews: itemNews,
    );
  }
}
