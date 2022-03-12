import 'package:flutter/material.dart';
import 'package:ichat/layout/main_layout.dart';
import 'package:provider/provider.dart';

import '../data/info.dart';
import '../provider/config_provider.dart';
import '../server/server_api.dart';
import '../widget/loader_widget.dart';
import '../database/users_db.dart';
import '../styles/theme_data.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  static const String pageId = "LoginLayout";

  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.watch<ConfigProvider>().getDarkTheme();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //! Logo
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 160,
                    maxHeight: 160,
                  ),
                  margin: const EdgeInsets.all(50),
                  child: Image.asset(
                    darkTheme ? "asset/images/logo_dark.png" : "asset/images/logo_light.png",
                  ),
                ),
                //! Title Username
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "نام کاربری خود را وارد کنید",
                    style: getTextTheme(context).bodyText1,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                //! Input Username
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: getColorTheme(context).onSecondary,
                  ),
                  child: TextField(
                    controller: usernameController,
                    readOnly: loading,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    maxLength: 10,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: getTextTheme(context).headline3?.copyWith(letterSpacing: 5),
                    cursorColor: getColorTheme(context).onSecondary,
                    decoration: InputDecoration(
                      hintText: "0000000000",
                      counterText: '',
                      hintStyle: getTextTheme(context).headline3?.copyWith(letterSpacing: 5, color: getTextTheme(context).headline3?.color?.withOpacity(0.5)),
                      hintTextDirection: TextDirection.rtl,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                //! Title Password
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "رمز عبور خود را وارد کنید",
                    style: getTextTheme(context).bodyText1,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                //! Input Password
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: getColorTheme(context).onSecondary,
                  ),
                  child: TextField(
                    controller: passwordController,
                    readOnly: loading,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    maxLength: 64,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    obscureText: true,
                    style: getTextTheme(context).headline3?.copyWith(letterSpacing: 5),
                    cursorColor: getColorTheme(context).onSecondary,
                    decoration: InputDecoration(
                      hintText: "********",
                      counterText: '',
                      hintStyle: getTextTheme(context).headline3?.copyWith(letterSpacing: 5, color: getTextTheme(context).headline3?.color?.withOpacity(0.5)),
                      hintTextDirection: TextDirection.rtl,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                //! Send Button
                GestureDetector(
                  child: Container(
                    height: 50,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: getColorTheme(context).surface,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ورود به سامانه',
                            style: getTextTheme(context).headline3,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                          Visibility(
                            visible: loading,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: LoaderWidget(
                                size: 25,
                                stroke: 3,
                                backgroundColor: Colors.transparent,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (valid()) {
                      await processLogin();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool valid() {
    if (usernameController.text.trim().isEmpty) {
      setStatus("نام کاربری خالی است", false);
      return false;
    } else if (usernameController.text.trim().length != 10) {
      setStatus("نام کاربری باید 10 حرف باشد", false);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      setStatus("رمز عبور خالی است", false);
      return false;
    } else if (passwordController.text.trim().length < 8) {
      setStatus("رمز عبور باید حداقل 8 حرف باشد", false);
      return false;
    } else {
      setStatus("لطفا صبر کنید", true);
      return true;
    }
  }

  Future<void> processLogin() async {
    //! Login
    setStatus("احراز هویت", true);
    CustomResponse customResponseLogin = await serverApi.login(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    if (customResponseLogin.networkStatus) {
      if (customResponseLogin.responsedata["login"] != null) {
        await setMyInfo(
          user: User.fromJson(customResponseLogin.responsedata["login"]),
          password: passwordController.text.trim(),
        );
        Navigator.pushReplacementNamed(context, MainLayout.pageId);
      }
    } else {
      setStatus("لطفا اتصال خود را برسی کنید", false);
    }
  }

  void setStatus(String text, bool loader) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: getColorTheme(context).secondaryContainer,
      content: Text(
        text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: getTextTheme(context).headline3,
      ),
    ));
    setState(() {
      loading = loader;
    });
  }
}
