import 'package:flutter/material.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:provider/provider.dart';

import '../layout/loader_layout.dart';
import '../provider/config_provider.dart';

class ErrorLayout extends StatefulWidget {
  const ErrorLayout({Key? key}) : super(key: key);

  static const String pageId = "ErrorLayout";

  @override
  _ErrorLayoutState createState() => _ErrorLayoutState();
}

class _ErrorLayoutState extends State<ErrorLayout> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: Column(
              children: [
                //! Logo
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 160,
                    minHeight: 160,
                  ),
                  margin: const EdgeInsets.all(50),
                  child: context.watch<ConfigProvider>().getDarkTheme()
                      ? Image.asset(
                          "asset/images/logo_dark.png",
                        )
                      : Image.asset(
                          "asset/images/logo_light.png",
                        ),
                ),
                //! Text
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "کاربر عزیز، اپلیکیشن به دلیل عملیات به روزرسانی",
                        style: getTextTheme(context).headline1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "تا ساعاتی دیگر در دسترس نیست.",
                        style: getTextTheme(context).headline1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "عذرخواهی ما را بپذیرید.",
                        style: getTextTheme(context).headline1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                //! Send Button
                GestureDetector(
                  child: Container(
                    height: 50,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.only(top: 60, bottom: 50, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: getColorTheme(context).primary),
                      color: getColorTheme(context).surface,
                    ),
                    child: Center(
                      child: Text(
                        'تلاش مجدد',
                        style: getTextTheme(context).headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, LoaderLayout.pageId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
