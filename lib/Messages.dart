import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';

class Messages extends StatefulWidget {
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  AsyncSnapshot<DocumentSnapshot>? snapshot;
  String? username;
  String? phone;
  String? email;
  var messagee = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // final user= FirebaseAuth.instance.currentUser;

  var massage = TextEditingController();

  @override
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('massages').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Send Message",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.blue.shade900,
                        title: Text('Send Message',
                            style: TextStyle(color: Colors.white)),
                        content: Container(
                          width: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[50]),
                          child: TextFormField(
                            controller: messagee,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.send, color: Colors.grey),
                              label: Text("Write Message",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          InkWell(
                              onTap: () {
                                setState(() {
                                  sendMessage(messagee.text);
                                  Navigator.of(ctx).pop();
                                });
                              },
                              child: Container(
                                  child: const Text("Send",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)))),
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
                        borderRadius: BorderRadius.circular(12)),
                    height: 50,
                  )),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.blue.shade900,
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["email"].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              width: context.width,
                              child: Text(
                                overflow: TextOverflow.visible,
                                " >> ${data["massage"]}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> sendMessage(var massage) async {
    var email;
    try {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Name, email address, and profile photo URL

          final email1 = user.email;

          // Check if user's email is verified

          email = email1;

          // The user's ID, unique to the Firebase project. Do NOT use this value to
          // authenticate with your backend server, if you have one. Use
          // User.getIdToken() instead.

        }

        // print("khaled   sdklsdkldskl${data['firstname']}");

      } catch (e) {
        //print(data['firstname']);
        print('error occured');
      }
      CollectionReference<Map<String, dynamic>> user =
          await FirebaseFirestore.instance.collection('massages');

      user.doc().set({
        'email': email,
        "massage": massage,
      });
    } on FirebaseAuthException catch (e) {
      print("Error don't send");
    }
  }
}
