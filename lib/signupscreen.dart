import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var check = true;
  var check2 = true;
  var email = TextEditingController();
  var password = TextEditingController();
  var password2 = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phonenumber = TextEditingController();

  void HidePassword() {
    setState(() {
      if (check == true) {
        check = false;
      } else {
        check = true;
      }
    });
  }

  void HidePassword2() {
    setState(() {
      if (check2 == true) {
        check2 = false;
      } else {
        check2 = true;
      }
    });
  }

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
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 30, 61, 106),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Text(
                      "Let's Get Started!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      "Create an account to get all features",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    )),
                    SizedBox(
                      height: 65,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: TxtFormName(
                            typecontrol: firstname,
                            prefixicon: Icons.person,
                            prefixIconiconColor: Colors.grey,
                            txt: "First Name")),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: TxtFormName(
                            typecontrol: lastname,
                            prefixicon: Icons.person,
                            prefixIconiconColor: Colors.grey,
                            txt: "Last Name")),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: TxtFormPhone(
                            typecontrol: phonenumber,
                            Txtinput: TextInputType.phone,
                            prefixicon: Icons.phone,
                            prefixIconiconColor: Colors.grey,
                            txt: "Phone Number")),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: TxtFormEmail(
                            Txtinput: TextInputType.emailAddress,
                            typecontrol: email,
                            prefixicon: Icons.email_outlined,
                            prefixIconiconColor: Colors.grey,
                            txt: "E-mail")),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white),
                        child: TxtFormPassword(
                            typecontrol: password2,
                            isCheck: check2,
                            prefixicon: Icons.lock_outline,
                            prefixIconiconColor: Colors.grey,
                            txt: "Confirm Password",
                            hidepassword: HidePassword2,
                            suffixicon: Icons.remove_red_eye_outlined,
                            suffixIconcolor: Colors.grey)),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email.text) ||
                                password.toString().isEmpty ||
                                password2.toString().isEmpty ||
                                firstname.toString().isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(firstname.text) ||
                                !RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(lastname.text) ||
                                lastname.toString().isEmpty ||
                                password2.text == password.text) {
                              if (formKey.currentState!.validate()) {
                                if (formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  signup(
                                      email.text,
                                      password.text,
                                      firstname.text,
                                      lastname.text,
                                      phonenumber.text);
                                }
                              }
                              // addUser(email.text,firstname.text,
                              //     lastname.text, phonenumber.text);
                            }
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 30, 61, 106),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup(var email, password, firstname, lastname, phone) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference<Map<String, dynamic>> user =
          await FirebaseFirestore.instance.collection('users');

      user.doc(userCredential.user!.uid).set({
        'firstname': firstname,
        'lasttname': lastname,
        'phonenum': phone,
        'email': email,
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.blue.shade900,
          title: Text('Success message', style: TextStyle(color: Colors.white)),
          content: Text("Successfully registered",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Container(
                  child: const Text("okay",
                      style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.blue.shade900,
          title: Text('Error Massage', style: TextStyle(color: Colors.white)),
          content: Text("$e", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                  child: const Text("okay",
                      style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );
    }
  }
}
