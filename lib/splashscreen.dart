import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handlrData(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
          ),
          Center(
              child: Icon(
            Icons.store_mall_directory,
            size: 300,
            color: Colors.blue.shade900,
          )),
          Spacer(),
          Text(
            "",
            style: TextStyle(color: Colors.blue.shade900),
          ),
        ],
      ),
    );
  }

  Future<void> handlrData(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacementNamed("login_screen");
  }
}
