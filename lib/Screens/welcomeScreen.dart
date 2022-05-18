import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:flutter/material.dart';

import '../Resources/commonClass.dart';

///MARK:- The welcome screen which is the initial route
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const SizedBox(
          height: 57,
          child: Logo(),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          SkipButton(
              navigatorContext: context,
              navigatorRouteName: Routes.HomeScreen.name,
              isWelcomeScreen: true),
        ],
      ),
      bodyChild: SafeArea(
        left: false,
        right: false,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              child: Image(
                fit: BoxFit.fill,
                width: double.infinity,
                image: AssetImage("images/model.png"),
              ),
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  "Face Analysis-Your Complete Beauty Guide",
                  style: Constants.customTitleStyle(
                      isUnderlined: true, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  String.fromCharCode(0x2022) +
                      "  Scan \n" +
                      String.fromCharCode(0x2022) +
                      "  Personalized solutions \n" +
                      String.fromCharCode(0x2022) +
                      "  Perform \n" +
                      String.fromCharCode(0x2022) +
                      "  Track \n" +
                      String.fromCharCode(0x2022) +
                      "  Repeat",
                  style: Constants.customTitleStyle(
                      isUnderlined: false, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Align(
              child: SizedBox(
                height: 45,
                width: 200,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.FaceScanning.name);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    "Get Started",
                    style: Constants.customTitleStyle(
                        isUnderlined: false,
                        fontSize: 14,
                        textColor: Constants.themeColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              child: SizedBox(
                child: Text(
                  "OR",
                  style: Constants.customTitleStyle(
                      isUnderlined: false, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              child: SizedBox(
                height: 50,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.LoginScreen.name);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Login",
                        style: Constants.customTitleStyle(
                            isUnderlined: true, fontSize: 18),
                      ),
                    ),
                    Text(
                      "/",
                      style: Constants.customTitleStyle(isUnderlined: false),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.RegistrationScreen.name);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Sign up",
                        style: Constants.customTitleStyle(
                            isUnderlined: true, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: null,
    );
  }
}
