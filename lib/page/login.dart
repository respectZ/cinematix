import 'package:cinematix/page/register.dart';
import 'package:flutter/material.dart';

import '../widget/cinematix_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CinematixContainer(
      bottomChild: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }),
              );
            },
            child: Text("Register"),
          ),
        ),
        Text("Belum Punya akun ?")
      ],
      formChild: [
        TextField(
          decoration: InputDecoration(
            hintText: 'username',
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
            child: Text("Login"),
          ),
        )
      ],
    ));
  }
}
