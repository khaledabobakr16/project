import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'forgetscreen.dart';
import 'homescreen.dart';
import 'loginscreen.dart';
import 'signupscreen.dart';
import 'splashscreen.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.width;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Shop_App());
}

class Shop_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      "/": (_) => SplashScreen(),
      "login_screen": (_) => LoginScreen(),
      "signup_screen": (_) => SignUpScreen(),
      "homescreen": (_) => MyAPPP()
    });
  }
}
