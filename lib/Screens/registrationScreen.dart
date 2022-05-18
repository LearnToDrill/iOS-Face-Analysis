import 'dart:ffi';
import 'dart:io';
import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../Resources/commonClass.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String fName = "First Name";
  String lName = "Last Name";
  String email = "Email";
  String password = "Password";
  String cPassword = "Confirm Password";

  final fNameC = TextEditingController();
  final lNameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final cPasswordC = TextEditingController();

  bool isObscure = false;

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    initParse();
    super.initState();
  }

  initParse() async {
    await Parse()
        .initialize(Constants.keyApplicationId, Constants.keyParseServerUrl);
  }

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
          child: Scrollbar(
            hoverThickness: 0.5,
            scrollbarOrientation: ScrollbarOrientation.right,
            thickness: 0.5,
            showTrackOnHover: true,
            isAlwaysShown: true,
            child: ListView(
              addRepaintBoundaries: false,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: textField(textFieldText: fName),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: textField(textFieldText: lName),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: textField(textFieldText: email),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child:
                        textField(textFieldText: password, isSecureText: true),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child:
                        textField(textFieldText: cPassword, isSecureText: true),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Align(
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextButton(
                      onPressed: () {
                        signUpPressed();
                      },
                      child: Text(
                        "Sign Up",
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
                    "Or\nSign Up Using",
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
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
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
                          "Already have an account?",
                          style: Constants.customTitleStyle(
                              isUnderlined: false, fontSize: 16, isBold: false),
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.LoginScreen.name);
                          },
                          child: Text(
                            "Login",
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
      drawer: null,
    );
  }

  signUpPressed() async {
    if (passwordC.text == cPasswordC.text) {
      var user = ParseUser.createUser(email, cPassword, email);
      user.set("firstName", fName);
      user.set("lastName", lName);
      var response = await user.signUp();
      if (response.success) {
        user = response.result;
      } else {
        showToast(response.error?.message ?? "");
      }
    } else {
      print("Passwords${passwordC.text} and cPassword${cPasswordC.text}");
      showToast("Passwords do not match!!", isError: true);
    }
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
          controller: textFieldText == fName
              ? fNameC
              : textFieldText == lName
                  ? lNameC
                  : textFieldText == email
                      ? emailC
                      : textFieldText == password
                          ? passwordC
                          : cPasswordC,
          decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
