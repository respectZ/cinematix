import 'package:cinematix/page/register.dart';
import 'package:flutter/material.dart';

import 'package:cinematix/controller/form_controller.dart';
import 'package:get/get.dart';

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
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
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
