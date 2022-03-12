import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ichat/layout/login_layout.dart';
import 'package:provider/provider.dart';

import '../database/boxes.dart';
import '../layout/main_layout.dart';
import '../provider/config_provider.dart';

class LoaderLayout extends StatefulWidget {
  const LoaderLayout({Key? key}) : super(key: key);

  static const String pageId = "LoaderLayout";

  @override
  _LoaderLayoutState createState() => _LoaderLayoutState();
}

class _LoaderLayoutState extends State<LoaderLayout> {
  @override
  void initState() {
    //! Full Screen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    //! Loader
    WidgetsBinding.instance?.addPostFrameCallback((_) => loader());
    //! initState
    super.initState();
  }

  @override
  void dispose() {
    //! Normal Screen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    //! Dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.watch<ConfigProvider>().getDarkTheme();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
              maxHeight: 200,
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, bottom: 100, top: 0),
            child: Image.asset(
              darkTheme ? "asset/images/logo_dark.png" : "asset/images/logo_light.png",
            ),
          ),
        ),
      ),
    );
  }

  loader() async {
    if (configBox.isEmpty) {
      Navigator.pushReplacementNamed(context, LoginLayout.pageId);
    } else {
      Navigator.pushReplacementNamed(context, MainLayout.pageId);
    }
  }
}
