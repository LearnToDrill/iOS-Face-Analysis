import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:flutter/material.dart';

import '../Resources/commonClass.dart';
import '../Resources/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "Email";
  String password = "Password";

  bool isObscure = true;
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
              navigatorRouteName: Routes.HomeScreen.name),
        ],
      ),
      bodyChild: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Scrollbar(
              hoverThickness: 0.5,
              scrollbarOrientation: ScrollbarOrientation.right,
              thickness: 0.5,
              showTrackOnHover: true,
              isAlwaysShown: true,
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: textField(textFieldText: email),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child:
                          textField(textFieldText: password, isSecureText: true),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Forgot Password?",
                        style: Constants.customTitleStyle(
                            isUnderlined: true, fontSize: 16, isBold: false),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Align(
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: Constants.customTitleStyle(
                              isUnderlined: false,
                              textColor: Constants.themeColor,
                              fontSize: 18),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    child: Text(
                      "Or\nSign In Using",
                      textAlign: TextAlign.center,
                      style: Constants.customTitleStyle(
                          isUnderlined: false, fontSize: 16, isBold: false),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              signInWithGoogle(context: context);
                            },
                            child: Image.asset("images/google.png"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              signInWithFacebook(context: context);
                            },
                            child: Image.asset("images/facebook.png"),
                          ),
                        ),
                        appleSignIn(context: context)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            "Do not have an account?",
                            style: Constants.customTitleStyle(
                                isUnderlined: false, fontSize: 16, isBold: false),
                          ),
                        ),
                        SizedBox(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.RegistrationScreen.name);
                            },
                            child: Text(
                              "Sign Up",
                              style: Constants.customTitleStyle(
                                  isUnderlined: true, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: null,
    );
  }

  SizedBox textField(
      {bool isSecureText = false, required String textFieldText}) {
    return SizedBox(
      height: 50,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Constants.themeColor,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        child: TextField(
          obscureText: isObscure,
          decoration: InputDecoration(
              suffix: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: isSecureText
                    ? IconButton(
                        color: Constants.themeColor,
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      )
                    : null,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(10.0),
              hintText: textFieldText,
              hintStyle: Constants.customTitleStyle(
                  isBold: false,
                  isUnderlined: false,
                  fontSize: 14,
                  textColor: Constants.themeColor),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: Constants.customTitleStyle(
                  isUnderlined: false,
                  fontSize: 14,
                  textColor: Constants.themeColor)),
          textAlign: TextAlign.justify,
          autocorrect: false,
          style: Constants.customTitleStyle(
              isUnderlined: false,
              fontSize: 14,
              textColor: Constants.themeColor),
          onChanged: (value) {
            textFieldText = value;
          },
        ),
      ),
    );
  }
}
