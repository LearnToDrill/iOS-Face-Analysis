import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'commonClass.dart';

final firebaseAuth = FirebaseAuth.instance;
bool didUserSkipScanning = false;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

signInWithGoogle({required BuildContext context}) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  //
  // Create a new credential
  if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
    final OAuthCredential? credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //
    // // Once signed in, return the UserCredential
    if (credential != null) {
      await firebaseAuth.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          Navigator.pushNamed(context, Routes.HomeScreen.name);
        }
      });
    }
  }

}

signInWithFacebook({required BuildContext context}) async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  String? accessToken = loginResult.accessToken?.token;
  if (accessToken != null) {
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken);
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      if (value.user != null) {
        Navigator.pushNamed(context, Routes.HomeScreen.name);
      }
    });
  }
}

signInWithApple({required BuildContext context}) async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  await FirebaseAuth.instance
      .signInWithCredential(oauthCredential)
      .then((value) {
    if (value.user != null) {
      Navigator.pushNamed(context, Routes.HomeScreen.name);
    }
  });
}

String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Widget appleSignIn({required BuildContext context}) {
  if (Platform.isIOS) {
    return SizedBox(
      height: 50,
      child: MaterialButton(
        onPressed: () {
          signInWithApple(context: context);
        },
        child: Image(
          color: Colors.white,
          image: AssetImage("images/apple.png"),
        ),
      ),
    );
  } else {
    return Center();
  }
}

class Constants {
  static const String baseUrl =
      "https://gserver1.btbp.org/deeptag/AppService.svc/";
  static const String APIKEY = "0ANJ-QSGS-M2KL-9UVY";
  static const keyApplicationId = "1b751cce-a6b7-11e8-98d0-529269fb1460";
  static const  keyParseServerUrl = "https://qaparse.oilschool.com/foreverYoung";
  static TextStyle titleTextStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18,
  );

  static Color themeColor = Color(0xFF6D012C);

  static TextStyle customTitleStyle(
      {required bool isUnderlined,
      double? fontSize = 28,
      Color? textColor = Colors.white,
      bool isBold = true}) {
    return GoogleFonts.poppins(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: textColor,
      fontSize: fontSize,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
