// ignore_for_file: constant_identifier_names

import 'dart:ffi';
// import 'dart:js';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Routes {
  WelcomeScreen,
  FaceScanning,
  BeautyPlanScreen,
  HomeScreen,
  RegistrationScreen,
  LoginScreen,
  OnBoardingScreen
}

SizedBox instructions(MediaQueryData view, String instruction,
    {double fontSize = 12, bool? isTypeAnimation = false}) {
  return SizedBox(
    height: view.size.width / 10,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Center(
        child: isTypeAnimation == true
            ? AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(instruction,
                      cursor: "",
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: Fonts.semiBold,
                        fontSize: fontSize,
                      ))
                ],
              )
            : Text(
                instruction,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: Fonts.semiBold,
                  fontSize: fontSize,
                ),
              ),
      ),
    ),
  );
}

// Dismiss the permission dialog
void dismissDialog(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

/// Ask User Camera permissions
Future<dynamic> askCameraPermission(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('Camera Permission'),
            content: Text(
                'This app needs camera access to take pictures for scanning skin issues'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Deny'),
                  onPressed: () {
                    dismissDialog(context);
                  }),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () {
                  openAppSettings();
                },
              ),
            ],
          ));
}

class Fonts {
  static FontWeight thin = FontWeight.w100;
  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}

showToast(String message, {bool isError = false}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError
          ? Constants.themeColor.withOpacity(0.8)
          : Colors.green.shade400,
      textColor: Colors.white,
      fontSize: 16.0);
}

SnackBar showSnack(String message, {bool isError = false}) {
  return SnackBar(
    backgroundColor:
        isError ? Constants.themeColor.withOpacity(0.8) : Colors.green.shade400,
    content: Text(
      message,
      style: Constants.customTitleStyle(
          isUnderlined: false, fontSize: 12, textColor: Colors.white),
    ),
    action: SnackBarAction(
      label: "Undo",
      onPressed: () {},
    ),
  );
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.only(
        left: (MediaQuery.of(context).size.width - 100) / 2,
        right: (MediaQuery.of(context).size.width - 100) / 2),
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierColor: Colors.white.withOpacity(0.2),
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Container itemsContainer({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
          colors: [Color(0xFF63B4FF), Colors.white],
          stops: [0.0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
    ),
    child: child,
  );
}
