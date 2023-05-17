import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
import 'homescreen.dart';

import 'loginscreen.dart';

class change extends StatefulWidget {
  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> {
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width,
          height: double.infinity,
          color: Colors.grey[50],
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyAPPP()));
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
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                "images/Forgotpassword.png",
                height: MediaQuery.of(context).size.height / 3,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Change Your Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
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
                          typecontrol: email,
                          prefixicon: Icons.email,
                          prefixIconiconColor: Colors.grey,
                          txt: "E-mail")),
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
                                          Navigator.of(ctx).pop();
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
                      width: 180,
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
