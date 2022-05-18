import 'package:face_analysis/Resources/constants.dart';
import 'package:face_analysis/Screens/BeautyPlanScreen.dart';
import 'package:face_analysis/Screens/FaceScanningScreen.dart';
import 'package:face_analysis/Screens/ScanResults/scanModel.dart';
import 'package:face_analysis/Screens/registrationScreen.dart';
import 'package:face_analysis/Screens/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'Resources/commonClass.dart';
import 'Screens/homeScreen.dart';
import 'Screens/loginScreen.dart';
import 'Screens/onBoardingScreen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {}
  final firstCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(
        camera: firstCamera,
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;
  User? user = firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      routes: {
        Routes.WelcomeScreen.name: (context) => WelcomeScreen(),
        Routes.HomeScreen.name: (context) => HomeScreen(),
        Routes.FaceScanning.name: (context) => FaceScanningScreen(
              camera: camera,
            ),
        Routes.BeautyPlanScreen.name: (context) => BeautyPlanScreen(
              results: ScanResults(),
            ),
        Routes.RegistrationScreen.name: (context) => RegistrationScreen(),
        Routes.LoginScreen.name: (context) => LoginScreen(),
        Routes.OnBoardingScreen.name: (context) => OnBoardingScreen()
      },
      initialRoute:
          user != null ? Routes.HomeScreen.name : Routes.WelcomeScreen.name,
      home: user != null ? HomeScreen() : WelcomeScreen(),
    );
  }
}
