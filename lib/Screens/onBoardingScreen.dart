import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Screens/onBoardingModel.dart';
import 'package:flutter/material.dart';

import '../Resources/commonClass.dart';
import '../Resources/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Onboarding> onboarding = [
    Onboarding(
      question: "Would you like an expert involved in giving you feedback?",
      options: ["Yes", "No"],
      popText:
          "Our experts will help you in the gradual progression of your glow journey.",
    ),
    Onboarding(
      question:
          "How often do you want to scan the face and check your improvement?",
      options: [
        "Once every week",
        "Once every 2 weeks",
        "Once in a month",
        "Never"
      ],
      popText:
          "The skin scores obtained every time will help you track your progress.",
    ),
    Onboarding(
      question: "What is your primary goal?",
      options: [
        "Reduce aging - Look Younger",
        "Skin Issues",
        "No Issues - Look prettier."
      ],
      popText:
          "We would like to provide you with solutions based on your Goal..",
    )
  ];

  List<Widget> options = [];
  int selectedQuestion = 0;
  int selectedIndex = 0;
  bool isSelected = false;
  String selectedAnswer = "";
  @override
  void initState() {
    setupOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final view = MediaQuery.of(context).size;
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
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 18.0),
          child: SizedBox(
            height: 50,
            width: view.width / 1.5,
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (selectedAnswer.isEmpty == true) {
                    showToast("Please select an answer to continue!!",
                        isError: true);
                    return;
                  }
                  if (selectedQuestion <
                      onboarding[selectedQuestion].options.length - 1) {
                    showToast("Selected answer is:  $selectedAnswer");
                    selectedQuestion++;
                    selectedAnswer = "";
                    setupOptions();
                  } else {
                    resetQuestions();
                    Navigator.pushNamed(context, Routes.HomeScreen.name);
                  }
                });
              },
              child: Text(
                "Continue",
                style: Constants.customTitleStyle(
                    isUnderlined: false,
                    textColor: Constants.themeColor,
                    fontSize: 18),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ),
        ),
        bodyChild: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView(
              children: [
                Align(
                  child: SizedBox(
                    child: Text(
                      "Personalization Questions",
                      style: Constants.customTitleStyle(
                          isUnderlined: false, fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  child: SizedBox(
                    child: Text(
                      onboarding[selectedQuestion].question,
                      textAlign: TextAlign.center,
                      style: Constants.customTitleStyle(
                          isUnderlined: false, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: () {
                      showPopUp(view);
                    },
                    child: Text(
                      "Why we ask this question?",
                      style: Constants.customTitleStyle(
                          isUnderlined: true, fontSize: 16, isBold: false),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: view.width / 6,
                        runSpacing: view.width / 6,
                        children: options,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void resetQuestions() {
    selectedAnswer = "";
    selectedQuestion = 0;
    setupOptions();
  }

  Widget resetQuestion3s() {
    return FutureBuilder(builder: (BuildContext, snapshot) {
      return Container();
    });
  }

  List<Widget> setupOptions() {
    options.length = 0;
    onboarding[selectedQuestion].options.asMap().forEach((key, value) {
      if (options.length < onboarding[selectedQuestion].options.length) {
        options.add(
          optionContainer(value, key, false),
        );
      }
    });
    return options;
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
            backgroundColor: Colors.white,
            content: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                      child: Text(
                        onboarding[selectedQuestion].popText,
                        textAlign: TextAlign.center,
                        style: Constants.customTitleStyle(
                            textColor: Colors.black,
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

  SizedBox optionContainer(String optionText, int index, bool isEnabled) {
    Text textButton = Text(
      optionText,
      textAlign: TextAlign.center,
      style: Constants.customTitleStyle(
          isUnderlined: false, fontSize: 16, textColor: Colors.black),
    );
    return SizedBox(
      height: 120,
      width: 120,
      child: Material(
        color: isEnabled ? Colors.grey.shade600 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          onPressed: () {
            setState(() {
              isEnabled = !isEnabled;
              selectedIndex = index;
              setupOptions();
              options[index] = optionContainer(optionText, index, isEnabled);
              selectedAnswer = isEnabled ? textButton.data ?? "" : "";
            });
          },
          child: textButton,
        ),
      ),
    );
  }
}
