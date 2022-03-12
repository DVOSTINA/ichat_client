import 'package:flutter/material.dart';
import 'package:ichat/page/search_page.dart';
import 'package:ichat/page/setting_page.dart';
import 'package:ichat/server/server_socket.dart';

import '../data.dart';
import '../page/groups_page.dart';
import '../widget/menu/menu_widget.dart';
import '../page/rooms_page.dart';
import '../styles/theme_data.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  static const String pageId = "MainLayout";

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  late PageController pageController;

  List<PageData> pageData = [
    PageData(
      icon: Icons.chat,
      active: true,
      widget: const RoomsPage(
        title: "پیام ها",
      ),
    ),
    PageData(
      icon: Icons.group,
      active: false,
      widget: const GroupsPage(
        title: "کانال و گروه ها",
      ),
    ),
    PageData(
      icon: Icons.search,
      active: false,
      widget: const SearchPage(
        title: "جستجو",
      ),
    ),
    PageData(
      icon: Icons.settings,
      active: false,
      widget: const SettingPage(
        title: 'تنظیمات',
      ),
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    socketManager = SocketManager();
    socketManager.socketListener(context);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    socketManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              //! Page
              PageView.builder(
                controller: pageController,
                itemCount: pageData.length,
                itemBuilder: itemPage,
                onPageChanged: onPageChanged,
              ),
              //! Menu
              Align(
                alignment: Alignment.bottomCenter,
                child: MenuWidget(
                  height: 70,
                  backgroundColor: getColorTheme(context).primary,
                  items: pageData,
                  onTaps: [
                    () {
                      onPageChanged(0);
                    },
                    () {
                      onPageChanged(1);
                    },
                    () {
                      onPageChanged(2);
                    },
                    () {
                      onPageChanged(3);
                    },
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemPage(BuildContext context, int index) {
    return pageData[index].widget;
  }

  void onPageChanged(int index) {
    setState(() {
      for (var item in pageData) {
        item.active = false;
      }
      pageData[index].active = true;
    });
    pageController.jumpToPage(index);
  }
}
