import 'package:flutter/material.dart';
import 'package:ichat/widget/button_contacts_widget.dart';

import '../page/contacts_groups_page.dart';
import '../page/contacts_users_page.dart';
import '../data.dart';
import '../Widget/menu/menu_widget.dart';
import '../styles/theme_data.dart';

class ContactLayout extends StatefulWidget {
  const ContactLayout({Key? key}) : super(key: key);

  static const String pageId = "ContactLayout";

  @override
  _ContactLayoutState createState() => _ContactLayoutState();
}

class _ContactLayoutState extends State<ContactLayout> {
  late PageController pageController;
  List<PageData> pageData = [
    PageData(
      icon: Icons.person,
      active: true,
      widget: const UsersContactsPage(
        title: "مخاطبین",
      ),
    ),
    PageData(
      icon: Icons.group,
      active: false,
      widget: const GroupsPage(
        title: 'کانال و گروه ها',
      ),
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ButtonContactsWidget(
        icon: Icons.close_rounded,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            color: getColorTheme(context).secondary,
          ),
          height: 50,
          child: MenuWidget(
            height: 50,
            backgroundColor: getColorTheme(context).primary,
            items: pageData,
            onTaps: [
              () {
                selectPage(0);
              },
              () {
                selectPage(1);
              },
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: getColorTheme(context).primary,
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            scrollBehavior: CustomScrollBehavior(),
            itemBuilder: (context, index) {
              return pageData[index].widget;
            },
            itemCount: pageData.length,
            onPageChanged: (index) {
              selectPage(index);
            },
          ),
        ),
      ),
    );
  }

  void selectPage(int index) {
    setState(() {
      for (var item in pageData) {
        item.active = false;
      }
      pageData[index].active = true;
    });
    pageController.jumpToPage(index);
  }
}
