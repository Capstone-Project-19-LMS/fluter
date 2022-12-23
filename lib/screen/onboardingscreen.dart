import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 17),
        bodyPadding: EdgeInsets.all(16));
    return IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
              title: "Belajar Dari Ahlinya",
              body:
                  "Pembelajaran dimentori oleh para ahli pada bidangnya masing - masing",
              image: Image.asset(
                'assets/image/onboarding1.png',
                width: 250,
              ),
              decoration: pageDecoration),
          PageViewModel(
              title: "Akses Modul Sepuasnya",
              body: "Modul berlimpah yang bebas diakses dimanapun dan kapanpun",
              image: Image.asset(
                'assets/image/onboarding2.png',
                width: 250,
              ),
              decoration: pageDecoration),
          PageViewModel(
            title: "Kelas Bersertifikat",
            body:
                "Ikuti kelas , kerjakan tugas dan kuis untuk mendapatkan sertifikat",
            image: Image.asset(
              'assets/image/onboarding3.png',
              width: 250,
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builder) {
                return LoginScreen();
              },
            ),
          );
        },
        showSkipButton: false,
        showNextButton: true,
        showDoneButton: true,
        showBackButton: true,
        back: const Icon(Icons.arrow_back),
        skip: const Text(
          'Skip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Lewati',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(10, 10),
          color: Colors.grey,
          activeSize: Size(22, 10),
          // activeShapes: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(25)))),
        ));
  }
}
