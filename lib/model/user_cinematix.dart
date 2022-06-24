import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserCinematix {
  final String __username;
  final String __name;
  final String __phone;
  final String __email;
  final String __password;
  final String? __photo;

  UserCinematix(
      {required String username,
      required String name,
      required String phone,
      required String email,
      required String password,
      String? photo})
      : __username = username,
        __name = name,
        __phone = phone,
        __email = email,
        __password = password,
        __photo = photo;

  factory UserCinematix.fromJSON(Map<String, dynamic> json) => UserCinematix(
      username: json['username'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      photo: json['photo'] as String);

  String getUsername() => __username;
  String getName() => __name;
  String getPhone() => __phone;
  String getEmail() => __email;
  String getPassword() => __password;
  String? getPhoto() => __photo;

  Future<void> uploadPhoto({required String path}) async {
    final storage = FirebaseStorage.instance.ref();
    File file = File(path);
    final ext = path.split(".")[path.split(".").length - 1];
    final uploadPath = "images/profile/" + getUsername() + "." + ext;
    var res = await storage.child(uploadPath).putFile(file);
    User? user = FirebaseAuth.instance.currentUser;
    await user!.updatePhotoURL(
        await FirebaseStorage.instance.ref(uploadPath).getDownloadURL());
  }
}
