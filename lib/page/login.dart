import 'package:cinematix/page/register.dart';
import 'package:flutter/material.dart';

import 'package:cinematix/controller/form_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widget/cinematix_container.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CinematixContainer(
        bottomChild: [
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: Text("Register"),
            ),
          ),
          Text("Belum Punya akun ?")
        ],
        formChild: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: 'username',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'password',
              prefixIcon: Icon(Icons.key),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (BuildContext context) {
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     });
                  // try {
                  //   UserCredential t = await FirebaseAuth.instance
                  //       .signInWithEmailAndPassword(
                  //           email: usernameController.text,
                  //           password: passwordController.text);
                  //   print(t.user!.email);
                  // } on FirebaseAuthException catch (e) {
                  //   Get.back();
                  //   if (e.code == "invalid-email") {
                  //   } else if (e.code == "wrong-password") {
                  //   } else {}
                  // }
                  // Get.back();
                  Get.offAndToNamed("/main");
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return const AlertDialog(
                  //         content: Text("To do."),
                  //       );
                  //     });
                } else if (usernameController.text.isNotEmpty &&
                    passwordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Password Kosong."),
                        );
                      });
                } else if (usernameController.text.isEmpty &&
                    passwordController.text.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Username Kosong."),
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Username & Password Kosong."),
                        );
                      });
                }
              },
              child: Text("Login"),
            ),
          )
        ],
      ),
    );
  }
}
