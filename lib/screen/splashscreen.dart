import 'package:flutter/material.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/screen/onboardingscreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splash = SplashScreenView(
      navigateRoute: OnboardingScreen(),
      duration: 500,
      imageSize: 150,
      imageSrc: "assets/image/splash.png",
      // text: "Hello",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.black,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.red,
      ],
      speed: 10,
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Splash Screen',
      home: splash,
    );
  }
}
