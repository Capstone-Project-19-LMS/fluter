import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kelompok19lmsproject/screen/homescreen.dart';
import 'package:kelompok19lmsproject/screen/index.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/screen/onboardingscreen.dart';
import 'package:kelompok19lmsproject/screen/registscreen.dart';
import 'package:kelompok19lmsproject/screen/splashscreen.dart';
import 'package:kelompok19lmsproject/screen/verif_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int introduction = 0;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  // await initIntroduction();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// // Future initIntroduction() async {
// //   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
  // final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//   int? intro = prefs.getInt('introduction');
//   print('intro : $intro');
//   if (intro != null && intro == 1) {
//     return introduction = 1;
//   }
//   prefs.setInt('introduction', 1);
// }

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    return MaterialApp(
        builder: EasyLoading.init(
            builder: (context, child) => FlutterEasyLoading(child: child)),
        title: 'Splash Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: true,

        // home: introduction == 0 ? SplashScreen() : LoginScreen(),
        home: isLoggedIn ? const Index() : const LoginScreen(),
        // initialRoute: '/splash',

        home: introduction == 0 ? SplashScreen() : LoginScreen(),

        routes: {
          '/splash': (context) => SplashScreen(),
          '/onboarding': (context) => OnboardingScreen(), 
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistScreen(),
          '/home': (context) => Index()
          '/index': (context) => Index()
        });
  }
}
