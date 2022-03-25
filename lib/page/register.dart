import 'package:cinematix/page/login.dart';
import 'package:flutter/material.dart';

// import 'package:cinematix/widget/cinematix_container.dart';
import '../widget/cinematix_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CinematixContainer(
      formChild: [
        TextField(
          decoration: InputDecoration(
            hintText: 'username',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'nama lengkap',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'email',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'no hp',
          ),
        ),
        TextField(
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            hintText: 'password',
          ),
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Register"),
          ),
        )
      ],
      bottomChild: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Login"),
          ),
        ),
        const Text("Sudah Punya Akun ?")
      ],
    ));
  }
}
