import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data.dart';
import '../data/info.dart';
import '../server/server_api.dart';
import '../styles/theme_data.dart';
import '../widget/loader_widget.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  static const String pageId = "ProfileLayout";

  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  TextEditingController firstNameController = TextEditingController(text: getMyInfo().firstName);
  TextEditingController lastNameController = TextEditingController(text: getMyInfo().lastName);

  ScrollController scrollController = ScrollController();

  bool loading = false;

  String status = "";

  XFile? profile;
  Uint8List? profileBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: getSizeScreenSafe(context).width,
          padding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //! Profile
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColorTheme(context).onSecondary,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: profile == null
                            ? Image.network(
                                "getIpProfile(true) + getMyInfo().id.toString() + '.jpg'",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  );
                                },
                              )
                            : Image.memory(profileBytes!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (await Permission.storage.request().isGranted) {
                                ImagePicker imagePicker = ImagePicker();
                                profile = await imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 60,
                                );
                                setState(() {
                                  status = "تصویر انتخاب شد";
                                });
                              }
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColorTheme(context).secondary,
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                size: 25,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (await Permission.storage.request().isGranted) {
                                ImagePicker imagePicker = ImagePicker();
                                profile = await imagePicker.pickImage(
                                  source: ImageSource.camera,
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 60,
                                );
                                setState(() {
                                  status = "تصویر انتخاب شد";
                                });
                              }
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColorTheme(context).secondary,
                              ),
                              child: const Icon(
                                Icons.photo_camera_outlined,
                                size: 25,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //! FirstName Text
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "نام خود را وارد کنید",
                      style: getTextTheme(context).bodyText1,
                    ),
                  ),
                  //! Input FirstName
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Material(
                      color: getColorTheme(context).secondary,
                      child: TextField(
                        controller: firstNameController,
                        readOnly: loading,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        maxLength: 64,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        cursorColor: getColorTheme(context).onTertiary,
                        decoration: InputDecoration(
                          hintText: "نام",
                          counterText: '',
                          hintStyle: getTextTheme(context).headline1?.copyWith(letterSpacing: 5, color: getTextTheme(context).headline1?.color?.withOpacity(0.5)),
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
                  ),
                  //! LastName Text
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "نام خانوادگی خود را وارد کنید",
                      style: getTextTheme(context).bodyText1,
                    ),
                  ),
                  //! Input LastName
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Material(
                      color: getColorTheme(context).secondary,
                      child: TextField(
                        readOnly: loading,
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        maxLength: 64,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        cursorColor: getColorTheme(context).onTertiary,
                        decoration: InputDecoration(
                          hintText: "نام خانوادگی",
                          counterText: '',
                          hintStyle: getTextTheme(context).headline1?.copyWith(color: getTextTheme(context).headline1?.color?.withOpacity(0.5)),
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
                  ),
                  //! Status
                  Visibility(
                    visible: status.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        status,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: getTextTheme(context).headline1,
                      ),
                    ),
                  ),
                  //! Send Button
                  GestureDetector(
                    child: Container(
                      height: 50,
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: getColorTheme(context).surface,
                      ),
                      child: loading
                          ? const Center(
                              child: LoaderWidget(
                                backgroundColor: Colors.transparent,
                                color: Colors.white,
                              ),
                            )
                          : Center(
                              child: Text(
                                'ذخیره اطلاعات',
                                style: getTextTheme(context).headline3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      Response response = await serverApi.setProfile(firstNameController.text, lastNameController.text, profile!);
                      if (response.statusCode == 200) {
                        Map<String, dynamic> data = jsonDecode(response.body);
                        switch (data["status"]) {
                          case 0:
                            setState(() {
                              status = "اطلاعات ذخیره شد";
                            });
                            Navigator.pop(context);
                            break;
                          default:
                            setState(() {
                              status = "شما اجازه تغییر اطلاعات را ندارید";
                            });
                        }
                      } else {
                        setState(() {
                          status = "اطلاعات ذخیره نشد لطفا دوباره تلاش کنید";
                        });
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.transparent,
                  child: const Icon(Icons.close_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
