import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
import 'change.dart';

import 'loginscreen.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width,
          decoration: BoxDecoration(
            color: Colors.grey[50],
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[50],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blueGrey,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 200,
                  width: context.width,
                  child: Image.asset("images/Forgotpassword.png")),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Reset Your Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Text("Lost your password Please enter your email address.",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(
                      "You will receive a link to create a new password via email.",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[50]),
                    child: TxtFormEmail(
                        prefixIconiconColor: Colors.grey,
                        prefixicon: Icons.email,
                        txt: "E-mail",
                        typecontrol: email,
                        Txtinput: TextInputType.emailAddress),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (email.text.isEmpty ||
                            !email.text.contains('@') ||
                            !email.text.contains('.')) {
                          print('Invalid email!');
                        } else {
                          try {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.sendPasswordResetEmail(email: email.text);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: Text('Sucessfull Massage',
                                    style: TextStyle(color: Colors.white)),
                                content: Text("check your email",
                                    style: TextStyle(color: Colors.white)),
                                actions: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => change()),
                                            (Route<dynamic> route) => false,
                                          );
                                        });
                                      },
                                      child: Container(
                                          child: const Text("okay",
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                ],
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            print(e.message);
                          }
                        }
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
