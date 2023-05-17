import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? uid;

class AuthenticationHelper {
  String? Uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp(
      {String? email,
      String? password,
      String? firstname,
      String? lastname,
      String? phonenum}) async {
    try {
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addUser(
      String firstname, String lasttname, String phonenum, String email) {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid.toString());

    return users
        .set({
          'firstname': firstname, // John Doe
          'lasttname': lasttname, // Stokes and Sons
          'phonenum': phonenum,
          'email': email
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //SIGN IN METHOD
  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      uid = user.uid;
      print("kkkhjbkbjh${uid!}");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetpassword(String? email) async {
    try {
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    //deleblackl();
  }

  String getCurrentUID() {
    Uid = user.uid;
    return uid!;
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
