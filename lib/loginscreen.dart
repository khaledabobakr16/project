import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
import 'adminpage.dart';
import 'signupscreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'forgetscreen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var check = true;
  var email = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Image.asset("images/logologin.png"),
                        Positioned(
                            bottom: 25,
                            left: 132,
                            child: Text(
                              "Welcome back!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        Positioned(
                            bottom: 7,
                            left: 100,
                            child: Text(
                              "Login in to your existant account ",
                              style: TextStyle(color: Colors.blueGrey),
                            )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey[50],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey[50]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Colors.white),
                            child: TxtFormEmail(
                                typecontrol: email,
                                prefixicon: Icons.email_outlined,
                                prefixIconiconColor: Colors.grey,
                                txt: "E-mail")),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Colors.white),
                            child: TxtFormPassword(
                                typecontrol: password,
                                isCheck: check,
                                prefixicon: Icons.lock_outline,
                                prefixIconiconColor: Colors.grey,
                                txt: "Password",
                                hidepassword: HidePassword,
                                suffixicon: Icons.remove_red_eye_outlined,
                                suffixIconcolor: Colors.grey)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetScreen()));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Forget Password?",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                AuthenticationHelper()
                                    .signIn(
                                        email: email.text,
                                        password: password.text)
                                    .then((result) {
                                  if (result == null) {
                                    if (email.text == "admin@gmail.com" &&
                                        password.text == "123456789") {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Admin()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyAPPP()),
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        backgroundColor:
                                            Color.fromARGB(255, 22, 49, 88),
                                        title: Text('Error Massage',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        content: Text("$result",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                                child: const Text("okay",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Text('Loading...', style: TextStyle(fontSize: 20),),
                                      //SizedBox(width: 10,),
                                      CircularProgressIndicator(
                                        color: Colors.blue.shade900,
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: 40,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 30, 61, 106),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                        child: Text(
                                      "LOG IN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: const [
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                            endIndent: 5,
                            indent: 70,
                            thickness: 2,
                          )),
                          Text("OR"),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              endIndent: 70,
                              indent: 5,
                              thickness: 2,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                signInWithFacebook();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 5, 48, 83),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.facebook_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "acebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 224, 60, 5),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/google.png",
                                        fit: BoxFit.fill,
                                        height: 15,
                                        width: 15,
                                        //color: Color.fromARGB(255, 224, 60, 5),
                                      ),
                                      SizedBox(width: 1),
                                      Text(
                                        "oogle",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                "Don't have accounts?",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Container(
                                child: const Text(
                                  " Sign Up",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result = await auth.signInWithCredential(credential);
    User? user = result.user;

    if (user != null) {
      print("done");
      String fn = get_first_name(user.displayName!);
      String ln = get_last_name(user.displayName!);
      addUser(
          fn,
          ln,
          user.phoneNumber == null ? "0123456789" : user.phoneNumber.toString(),
          user.email!,
          user.photoURL!);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyAPPP()),
        (Route<dynamic> route) => false,
      );
    } // if result not null we simply call the MaterialpageRoute,
    // for go to the HomePage screen
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential result =
        await auth.signInWithCredential(facebookAuthCredential);
    User? user = result.user;

    if (user != null) {
      print("done");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyAPPP()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void HidePassword() {
    setState(() {
      if (check == true) {
        check = false;
      } else {
        check = true;
      }
    });
  }

  Future addUser(String firstname, String lasttname, String phonenum,
      String email, String photo) {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString());

    return users
        .set({
          'firstname': firstname, // John Doe
          'lasttname': lasttname, // Stokes and Sons
          'phonenum': phonenum,
          'email': email,
          'photo': photo
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  get_first_name(String name) {
    var names = name.split(' ');
    String first_name = "";

    for (int i = 0; i != names.length; i++) {
      if (i != names.length - 1) {
        if (i == 0) {
          first_name = first_name + names[i];
        } else {
          first_name = first_name + " " + names[i];
        }
      }
    }
    return first_name; // Tony Stark is
  }

  get_last_name(String name) {
    var names = name.split(' ');
    return names[names.length - 1].toString(); // dead
  }
}
