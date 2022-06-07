import 'package:cinematix/model/user_cinematix.dart';
import 'package:cinematix/model/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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

  static Future<UserCinematix?> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection("user").get();
    // final users = querySnapshot.docs.map((e) {
    //   final _user = e.data();
    //   final _username = e.id;
    //   return {_username: _user};
    // }).toList();
    UserCinematix userCinematix = UserCinematix(
        name: user.displayName ?? "undefined",
        phone: user.phoneNumber ?? "undefined",
        email: user.email ?? "undefined",
        photo: user.photoURL,
        password: "-");
    return userCinematix;
  }

  static Future<void> updateUser(
      {String? displayName,
      String? photoURL,
      PhoneAuthCredential? phoneCredential}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    if (displayName != null) user.updateDisplayName(displayName);
    if (photoURL != null) user.updatePhotoURL(photoURL);
    if (phoneCredential != null) await user.updatePhoneNumber(phoneCredential);
  }

  static Future<void> addReview(
      {required int? movie_id,
      required String? user_email,
      required double? star_rating,
      required String? comment}) async {
    await FirebaseFirestore.instance
        .collection('review')
        .doc()
        .set({
          'movie_id': movie_id,
          'user_email': user_email,
          'star_rating': star_rating,
          'comment': comment
        })
        .whenComplete(() => print("review added to database"))
        .catchError((e) => print(e));
  }

  static Future<List<Review?>> getReview({required int? movie_id}) async {
    List<Review> review_data = [];
    QuerySnapshot review_by_movie_id = await FirebaseFirestore.instance
        .collection('review')
        .where('movie_id', isEqualTo: movie_id)
        .get();
    for (var i = 0; i < review_by_movie_id.docs.length; i++) {
      Review review_one = Review(
          movieId: review_by_movie_id.docs[i]['movie_id'],
          userEmail: review_by_movie_id.docs[i]['user_email'],
          starRating: review_by_movie_id.docs[i]['star_rating'].toDouble(),
          comment: review_by_movie_id.docs[i]['comment']);
      review_data.add(review_one);
    }
    return review_data;
  }
}



// void main() {
//   // var x = FireAuth.getReview(movie_id: 3);
//   print("yes");
// }
