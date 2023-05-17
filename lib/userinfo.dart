import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
class MyAccount extends StatelessWidget {

  final String documentId;

  MyAccount(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =  FirebaseFirestore.instance.collection('users');


    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<
                  String,
                  dynamic>;
              return Text("Full Name: ${data['email']}");
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}