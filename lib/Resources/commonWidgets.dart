import 'dart:io';
import 'package:face_analysis/Resources/commonClass.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset("images/Logo.png"),
    );
  }
}

class SkipButton extends StatelessWidget {
  SkipButton(
      {required this.navigatorRouteName,
      required this.navigatorContext,
      this.isWelcomeScreen});

  final String navigatorRouteName;
  final BuildContext navigatorContext;
  bool? isWelcomeScreen = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (isWelcomeScreen == true) {
          didUserSkipScanning = true;
        }
        Navigator.pushNamed(navigatorContext, navigatorRouteName);
      },
      child: Text(
        "Skip",
        style: Constants.customTitleStyle(isUnderlined: true, fontSize: 20),
      ),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  CustomScaffold(
      {this.appBar,
      this.drawer,
      this.bottomNavigationBar,
      required this.bodyChild});

  final AppBar? appBar;
  final Widget bodyChild;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.8),
              Color(0xFF6D0162).withOpacity(1),
              Color(0xFF6D012C).withOpacity(0.8),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.6, 1.0]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
        body: bodyChild,
      ),
    );
  }
}

Expanded iconTitleButton(
    {required String title,
    required Function btnAction,
    bool isHorizontal = false,
    required Image btnIcon,
    bool? hasCalendarIcon = true}) {
  return Expanded(
    child: TextButton(
        onPressed: () {
          btnAction();
        },
        child: isHorizontal
            ? Row(
                children: [
                  SizedBox(
                    child: btnIcon,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Constants.customTitleStyle(
                          isUnderlined: false,
                          fontSize: 16,
                          textColor: Constants.themeColor),
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: btnIcon,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Text(
                          title,
                          textAlign: TextAlign.justify,
                          style: Constants.customTitleStyle(
                              isUnderlined: false,
                              fontSize: 16,
                              textColor: Constants.themeColor),
                        ),
                      ),
                      Visibility(
                        replacement: SizedBox.shrink(),
                        visible: hasCalendarIcon!,
                        child: const Expanded(
                          child: Image(
                            fit: BoxFit.contain,
                            width: 20,
                            height: 20,
                            image: AssetImage("images/calendar.png"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
  );
}
