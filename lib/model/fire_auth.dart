import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return user;
  }

  static Future<User?> signIn(
      {required String username, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection("user").doc(username).get();
    if (!userDocument.exists) {
      throw FirebaseAuthException(code: "user-not-found");
    }
    try {
      // berarti ada
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: userDocument["email"], password: password);
      user = userCredential.user;
    } on StateError catch (e) {
      throw FirebaseAuthException(code: "user-not-found");
    }
    return user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
