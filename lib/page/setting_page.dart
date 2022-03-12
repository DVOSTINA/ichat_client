import 'package:flutter/material.dart';
import 'package:ichat/data/info.dart';
import 'package:ichat/layout/login_layout.dart';
import 'package:ichat/layout/profile_layout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../widget/header_widget.dart';
import '../provider/config_provider.dart';
import '../styles/theme_data.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ScrollController scrollController = ScrollController();

  bool loading = false;

  TextEditingController firstNameController = TextEditingController(text: getMyInfo().firstName);
  TextEditingController lastNameController = TextEditingController(text: getMyInfo().lastName);
  String status = "";

  late XFile? profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Header
        HeaderWidget(
          title: widget.title,
          status: "درحال اتصال",
          icon: Icons.wifi_rounded,
          showStatus: !context.watch<ConfigProvider>().getSocketStatus(),
        ),
        //! Setting Item
        Container(
          padding: const EdgeInsets.all(5),
          child: Wrap(
            children: [
              SettingItem(
                text: "پروفایل",
                icon: Icons.person,
                backgroundColor: getColorTheme(context).secondary,
                onTap: () {
                  Navigator.pushNamed(context, ProfileLayout.pageId);
                },
              ),
              SettingItem(
                text: "حالت شب",
                icon: Icons.light,
                backgroundColor: getColorTheme(context).secondary,
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return DialogCheck(
                        title: "اخطار",
                        text: "آیا میخواهید حالت شب را تغییر دهید؟",
                        onSuccess: () {
                          context.read<ConfigProvider>().setTheme();
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
              SettingItem(
                text: "خروج",
                icon: Icons.exit_to_app,
                backgroundColor: getColorTheme(context).secondary,
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return DialogCheck(
                        title: "اخطار",
                        text: "آیا میخواهید از اکانت خود خارج شوید؟",
                        onSuccess: () async {
                          await deleteInfo();
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, LoginLayout.pageId);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DialogCheck extends StatelessWidget {
  const DialogCheck({
    Key? key,
    required this.title,
    required this.text,
    required this.onSuccess,
    required this.onCancel,
  }) : super(key: key);

  final String title;
  final String text;
  final Function() onSuccess;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 170,
        width: getSizeScreenSafe(context).width,
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: getColorTheme(context).secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.end,
              style: getTextTheme(context).headline3,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.end,
              style: getTextTheme(context).headline4,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        color: getColorTheme(context).surface,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "تایید",
                          style: getTextTheme(context).headline4,
                        ),
                      ),
                    ),
                    onTap: onSuccess,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        color: getColorTheme(context).onSecondary,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "انصراف",
                          style: getTextTheme(context).headline4,
                        ),
                      ),
                    ),
                    onTap: onCancel,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;
  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: getSizeScreenSafe(context).width / 3 - 15,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: getTextTheme(context).headline4,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
