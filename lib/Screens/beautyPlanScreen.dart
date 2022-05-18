import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:face_analysis/Screens/ScanResults/scanModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import '../Resources/commonClass.dart';
import 'ScanResults/scanResultsScreen.dart';

class BeautyPlanScreen extends StatefulWidget {
  BeautyPlanScreen({Key? key, required this.results, this.imagePath})
      : super(key: key);
  final ScanResults results;
  final String? imagePath;

  @override
  State<BeautyPlanScreen> createState() => _BeautyPlanScreenState();
}

class _BeautyPlanScreenState extends State<BeautyPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final view = MediaQuery.of(context);
    double width = view.size.width;

    return CustomScaffold(
      appBar: AppBar(
        title: const SizedBox(
          height: 57,
          child: Logo(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(Routes.FaceScanning.name),
            );
          },
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios_rounded : Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          SkipButton(
              navigatorContext: context,
              navigatorRouteName: Routes.HomeScreen.name),
        ],
      ),
      bodyChild: BeautyPlanBody(
        width: width,
        results: widget.results,
        imagePath: widget.imagePath ?? "",
      ),
      drawer: null,
    );
  }
}

class BeautyPlanBody extends StatefulWidget {
  BeautyPlanBody(
      {Key? key,
      required this.width,
      required this.results,
      required this.imagePath})
      : super(key: key);
  final double width;
  final ScanResults results;
  final String imagePath;

  @override
  State<BeautyPlanBody> createState() => _BeautyPlanBodyState();
}

class _BeautyPlanBodyState extends State<BeautyPlanBody> {
  String skinAge = "";
  List<Widget> scores = [];
  Uint8List? scanImageBytes;
  @override
  Widget build(BuildContext context) {
    setupResults();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                "Your Beautification Analysis Report is ready!!!",
                textAlign: TextAlign.center,
                style: Constants.titleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: widget.width / 2,
                        height: (widget.width / 2) + 60,
                        child: scanImageBytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical((widget.width / 2) + 110,
                                      (widget.width / 2) + 210),
                                ),
                                child: Image.memory(scanImageBytes!,
                                    fit: BoxFit.fill),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical((widget.width / 2) + 110,
                                      (widget.width / 2) + 210),
                                ),
                                child: Image.file(
                                  File(widget.imagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical((widget.width / 2) + 110,
                                (widget.width / 2) + 210),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Text(
                              "Skin\nHealth:- $skinAge",
                              style: Constants.titleTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            child: Text(
                              "Skin\nAge:- $skinAge",
                              style: Constants.titleTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Image.asset("images/calendar.png"),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        "Schedule your exercises here",
                                        style: Constants.customTitleStyle(
                                            isUnderlined: false, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.OnBoardingScreen.name);
                      },
                      child: Text(
                        "Beauty\nPlan",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Constants.themeColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 26,
                ),
                SizedBox(
                  width: 150,
                  height: 55,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.FaceScanning.name);
                      },
                      child: Text(
                        "Get Advanced\nAnalysis",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Constants.themeColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            child: Text(
              "Beautification Scores",
              style: Constants.titleTextStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 12.0, top: 12.0),
              child: ListView(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    // spacing: 12,
                    children: scores,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  setupResults() {
    scores.length = 0;
    widget.results.Tags?.forEach((element) {
      if (element?.Status == true) {
        String? tagName = element?.TagName;
        if (tagName == Tags.WRINKLES_IMAGE_FAST.name) {
          String imgBytes = element?.TagValues?.first?.Value ?? "";
          scanImageBytes = Base64Decoder().convert(imgBytes);
        }
        if (tagName == Tags.SKINAGE.name) {
          skinAge = element?.TagValues?.first?.Value ?? element?.Message ?? "";
        } else if (tagName == Tags.SPOTS_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Spots",
            ),
          );
        } else if (tagName == Tags.WRINKLES_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Wrinkles",
            ),
          );
        } else if (tagName == Tags.DARK_CIRCLES_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "DarkCircles",
            ),
          );
        } else if (tagName == Tags.TEXTURE_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Texture",
            ),
          );
        } else if (tagName == Tags.OILINESS_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Oiliness",
            ),
          );
        } else if (tagName == Tags.REDNESS_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Redness",
            ),
          );
        } else if (tagName == Tags.ACNE_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Acne",
            ),
          );
        } else if (tagName == Tags.ELASTICITY.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Elasticity",
            ),
          );
        } else if (tagName == Tags.FIRMNESS.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Firmness",
            ),
          );
        } else if (tagName == Tags.NASOLABIAL_FOLDS_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Nasolabial Folds",
            ),
          );
        } else if (tagName == Tags.DEHYDRATION_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Dehydration",
            ),
          );
        } else if (tagName == Tags.PORES_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Pores",
            ),
          );
        } else if (tagName == Tags.SHININESS_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Shininess",
            ),
          );
        } else if (tagName == Tags.UNEVEN_SKINTONE_SEVERITY_SCORE_FAST.name) {
          scores.add(
            score(
              score: convertScore(element?.TagValues?.first?.Value ?? ""),
              tagName: "Uneven Skin-tone",
            ),
          );
        }
      }
    });
  }

  String convertScore(String value) {
    String stringScore = value;
    return ((((int.parse(stringScore)) / 5) * 100).toInt()).toString();
  }

  Widget score({required String score, required String tagName}) {
    return SizedBox(
      width: 60,
      height: 120,
      child: Column(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: const StadiumBorder(),
                side: const BorderSide(
                    width: 3, color: Colors.white, style: BorderStyle.solid),
              ),
              child: Text(
                score,
                style: Constants.titleTextStyle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              tagName,
              textAlign: TextAlign.start,
              style: Constants.customTitleStyle(
                  isUnderlined: false, fontSize: 14, textColor: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
