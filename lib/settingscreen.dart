import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'orders.dart';
import 'userinfo.dart';
import 'auth.dart';
import 'homescreen.dart';
import 'info.dart';
import 'loginscreen.dart';
import 'myaccountscreen.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isLoading = true;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user!.uid).get(),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage("${data['photo']}"),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      "${data['firstname']} ${data['lasttname']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Text(
                      "${data['email']}",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetUserName(user!.uid)),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.person),
                              Text(" My Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Icon(Icons.arrow_circle_right),
                              SizedBox(
                                width: 5,
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Orders()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.shopping_cart),
                              Text(" My Orders",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Icon(Icons.arrow_circle_right),
                              SizedBox(
                                width: 5,
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = false;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = true;
                            _signOut();
                          });
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: isLoading
                              ? Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.logout),
                                    Text(" Logout",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ]))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
//Text('Loading...', style: TextStyle(fontSize: 20),),
//SizedBox(width: 10,),
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        },
      ),
    ));
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
    deleblackl();
  }

  Future<void> deleblackl() async {
    final collection =
        await FirebaseFirestore.instance.collection("orders").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }
}
