import 'package:flutter/material.dart';
import 'package:ichat/page/contacts_page.dart';
import 'package:ichat/page/search_page.dart';
import 'package:ichat/page/setting_page.dart';
import 'package:ichat/server/server_socket.dart';
import 'package:ichat/widget/down_menu/down_menu_button_widget.dart';

import '../data.dart';
import '../page/rooms_page.dart';
import '../widget/down_menu/down_menu_widget.dart';

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
      icon: Icons.search,
      active: false,
      widget: const SearchPage(
        title: "جستجو",
      ),
    ),
    PageData(
      icon: Icons.group,
      active: false,
      widget: const ContactsPage(
        title: "مخاطبین",
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
      body: Stack(
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
            child: DownMenuWidget(
              item: [
                DownMenuButtonWidget(
                  width: getSizeScreenSafe(context).width / pageData.length,
                  icon: pageData[0].icon,
                  isActive: pageData[0].active,
                  onTap: () {
                    onPageChanged(0);
                  },
                ),
                DownMenuButtonWidget(
                  width: getSizeScreenSafe(context).width / pageData.length,
                  icon: pageData[1].icon,
                  isActive: pageData[1].active,
                  onTap: () {
                    onPageChanged(1);
                  },
                ),
                DownMenuButtonWidget(
                  width: getSizeScreenSafe(context).width / pageData.length,
                  icon: pageData[2].icon,
                  isActive: pageData[2].active,
                  onTap: () {
                    onPageChanged(2);
                  },
                ),
                DownMenuButtonWidget(
                  width: getSizeScreenSafe(context).width / pageData.length,
                  icon: pageData[3].icon,
                  isActive: pageData[3].active,
                  onTap: () {
                    onPageChanged(3);
                  },
                ),
              ],
            ),
          ),
        ],
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
