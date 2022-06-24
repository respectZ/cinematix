import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cinematix/model/user_cinematix.dart';
import 'package:cinematix/model/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FireAuth {
  static Future<void> register(
      {required String username,
      required String namaLengkap,
      required String email,
      required String no_hp,
      required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // cek dulu if username exists
      var usernameCollection = await FirebaseFirestore.instance
          .collection("user")
          .doc(username)
          .get();
      if (usernameCollection.exists) {
        throw FirebaseAuthException(code: "username-already-in-use");
      }
      // cek kalo nomorhp exists
      var listUser = await CinematixFirestore.getAllFromCollection(
          collection_name: "user");
      for (Map<String, dynamic> _user in listUser) {
        if (_user["phone"] == no_hp) {
          throw FirebaseAuthException(code: "phone-already-in-use");
        }
      }
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userCredential.user?.updateDisplayName(namaLengkap);
      // insert into collection
      await FirebaseFirestore.instance.collection("user").doc(username).set({
        "email": email,
        "nama": namaLengkap,
        "phone": no_hp,
      });
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      print(e);
    }
  }

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
    var users =
        await CinematixFirestore.getAllFromCollection(collection_name: "user");
    // Find from users where email = email
    users = users.where((element) => element["email"] == user.email).toList();
    var _user = users[0];
    UserCinematix userCinematix = UserCinematix(
        username: _user["id"],
        name: user.displayName ?? _user["nama"] ?? "undefined",
        phone: ((user.phoneNumber == "" || user.phoneNumber == null)
            ? _user["phone"]
            : "undefined"),
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
      {required String movie_id,
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

  static Future<List<Review?>> getReview({required String movie_id}) async {
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

  static Future<void> AddUserFavorite({required String movie_id}) async {
    var username = await FireAuth.getCurrentUser();
    await FirebaseFirestore.instance
        .collection('user_favorite')
        .add({'username': username!.getUsername(), 'movie': movie_id});
  }

  static Future<void> DeleteUserFavorite(
      {String? username, int? movie_id}) async {
    // to do
  }

  static Future<bool> toggleUserFavorite({required String movie_id}) async {
    var username = (await getCurrentUser())!.getUsername();
    var favorites =
        await FirebaseFirestore.instance.collection("user").doc(username).get();
    var favoritesData = favorites.data()!["favorites"] as List<dynamic>;
    var _movie = FirebaseFirestore.instance.doc("movie/${movie_id}");
    bool res = false;
    if (favoritesData.contains(_movie)) {
      favoritesData.remove(_movie);
    } else {
      favoritesData.add(_movie);
      res = true;
    }
    await FirebaseFirestore.instance
        .collection("user")
        .doc(username)
        .update({"favorites": favoritesData});
    return res;
  }

  static Future<bool> isUserFavorite({required String movie_id}) async {
    var username = (await getCurrentUser())!.getUsername();
    // cek dulu kalo di document udh punya / blm
    var favorites =
        await FirebaseFirestore.instance.collection("user").doc(username).get();
    if (favorites.data()!["favorites"] == null) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(username)
          .update({"favorites": []});
      return false;
    } else {
      var _movie = FirebaseFirestore.instance.doc("movie/${movie_id}");
      if ((favorites.data()!["favorites"] as List).contains(_movie)) {
        return true;
      }
      return false;
    }
    // bikin doc baru

    // get, append movie ke array list
  }

  static Future<void> buyTicket({required String ticketId}) async {
    var user = await FireAuth.getCurrentUser();
    var querySnapshot = await FirebaseFirestore.instance
        .collection("user_ticket")
        .doc(user!.getUsername())
        .get();
    // var tickets = querySnapshot.data()?["tickets"] as List<dynamic>;
    await FirebaseFirestore.instance
        .collection("user_ticket")
        .doc(user.getUsername())
        .set({
      "tickets": [ticketId]
    });
  }
}



// void main() {
//   // var x = FireAuth.getReview(movie_id: 3);
//   print("yes");
// }
