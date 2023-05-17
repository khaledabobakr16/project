import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'change.dart';
import 'home.dart';
import 'homescreen.dart';
import 'settingscreen.dart';

class GetUserName extends StatefulWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  var newfirstname = TextEditingController();

  var newlastname = TextEditingController();

  var newphone = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final user = FirebaseAuth.instance.currentUser;

  Future<void> updateUserFN(String? NFW) {
    return users
        .doc(user!.uid)
        .update({'firstname': NFW})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateUserLN(String? LN) {
    return users
        .doc(user!.uid)
        .update({'lasttname': LN})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateUserPH(String? PH) {
    return users
        .doc(user!.uid)
        .update({'phonenum': PH})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAPPP()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Container(
                                width: 420,
                                color: Colors.blue.shade900,
                                child: Center(
                                    child: Text("Your Information",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35)))),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person,
                                              color: Colors.grey),
                                          hintText:
                                              "First Name: ${data['firstname']}",
                                          hintStyle: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                  color: Colors.blue.shade900)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: Text('Change first name',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newfirstname,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  label: Text("New first name",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserFN(
                                                          newfirstname.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: Container(
                                                      child: const Text(
                                                          "change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(color: Colors.grey),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person,
                                              color: Colors.grey),
                                          hintText:
                                              "Last Name: ${data['lasttname']}",
                                          hintStyle: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                  color: Colors.blue.shade900)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: Text('Change last name',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newlastname,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  label: Text("New last name",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserLN(
                                                          newlastname.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: Container(
                                                      child: const Text(
                                                          "change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.phone,
                                                color: Colors.grey),
                                            hintText:
                                                "phone: ${data['phonenum']}",
                                            hintStyle: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.blue.shade900))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: Text('Change phone number',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newphone,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.phone,
                                                      color: Colors.white),
                                                  label: Text("New phone",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserPH(
                                                          newphone.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: Container(
                                                      child: const Text(
                                                          "change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        child: TextFormField(
                                          readOnly: true,
                                          //controller: email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.lock,
                                                  color: Colors.grey),
                                              hintText: "Change Password ",
                                              hintStyle: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontWeight: FontWeight.bold),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .blue.shade900))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    change()));
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.email,
                                                color: Colors.grey),
                                            hintText:
                                                "E-mail: ${data['email']}",
                                            hintStyle: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.blue.shade900))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.no_encryption,
                                      color: Colors.white,
                                    ),
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade900,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
