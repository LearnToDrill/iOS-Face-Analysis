import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart';

import '../../Resources/commonClass.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: null,
          automaticallyImplyLeading: false,
          title: const SizedBox(
            height: 57,
            child: Logo(),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
        bodyChild: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Align(
                  child: SizedBox(
                    child: Text(
                      "Update Your Profile Here!",
                      style: Constants.customTitleStyle(
                        isUnderlined: false,
                        fontSize: 16,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        showPopUp(MediaQuery.of(context).size);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        backgroundImage: AssetImage("images/femaleicon.png"),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 70.0, left: 70),
                                child: ImageIcon(
                                  AssetImage("images/editProfile.png"),
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        radius: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  child: SizedBox(
                    child: Text(
                      "User Name",
                      style: Constants.customTitleStyle(
                          isUnderlined: false,
                          textColor: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  child: SizedBox(
                    child: Text(
                      "User email",
                      style: Constants.customTitleStyle(
                          isUnderlined: false,
                          textColor: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  child: isAuthenticated(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget isAuthenticated() {
    return Container(
      child: Column(
        children: [
          Text(
            "Don't have an account?",
            style: Constants.customTitleStyle(
              isUnderlined: false,
              textColor: Colors.white,
              fontSize: 16,
              isBold: false,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 45,
            width: 180,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.RegistrationScreen.name);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                "Sign Up",
                style: Constants.customTitleStyle(
                  isUnderlined: false,
                  fontSize: 14,
                  textColor: Constants.themeColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Or",
            style: Constants.customTitleStyle(
              isUnderlined: false,
              textColor: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 45,
            width: 180,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.LoginScreen.name);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                "Login",
                style: Constants.customTitleStyle(
                  isUnderlined: false,
                  fontSize: 14,
                  textColor: Constants.themeColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showPopUp(Size view) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.only(left: view.width / 5, right: view.width / 5),
            contentPadding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            scrollable: true,
            backgroundColor: Colors.grey.shade300,
            content: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: Text(
                          "Update your profile picture",
                          style: Constants.customTitleStyle(
                            isUnderlined: true,
                            fontSize: 14,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Take a picture",
                        textAlign: TextAlign.center,
                        style: Constants.customTitleStyle(
                            textColor: Constants.themeColor,
                            isUnderlined: false,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {},
                      title: Text(
                        "Upload a picture",
                        textAlign: TextAlign.center,
                        style: Constants.customTitleStyle(
                            textColor: Constants.themeColor,
                            isUnderlined: false,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Remove picture",
                        textAlign: TextAlign.center,
                        style: Constants.customTitleStyle(
                            textColor: Colors.red.shade900,
                            isUnderlined: false,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
