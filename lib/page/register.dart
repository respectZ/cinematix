import 'package:cinematix/model/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/cinematix_container.dart';

enum ErrorStatus {
  none,
  shortUsername,
  shortName,
  invalidPhone,
  invalidEmail,
  weakPassword
}

bool _validateUsername(String username) =>
    RegExp(r"^[^\W_]{6,}$").hasMatch(username);

bool _validateEmail(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool _validateNomorHP(String nomor_hp) =>
    RegExp(r"[0-9]{10,14}$").hasMatch(nomor_hp);

bool _validatePassword(String password) =>
    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})").hasMatch(password);

ErrorStatus _validate(
    {required String username,
    required String namaLengkap,
    required String email,
    required String no_hp,
    required String password}) {
  if (!_validateUsername(username))
    return ErrorStatus.shortUsername;
  else if (namaLengkap.length < 6)
    return ErrorStatus.shortName;
  else if (!_validateEmail(email))
    return ErrorStatus.invalidEmail;
  else if (!_validateNomorHP(no_hp))
    return ErrorStatus.invalidPhone;
  else if (!_validatePassword(password)) return ErrorStatus.weakPassword;
  return ErrorStatus.none;
}

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController username_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  TextEditingController nama_lengkap_c = TextEditingController();
  TextEditingController email_c = TextEditingController();
  TextEditingController no_hp_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CinematixContainer(
      formChild: [
        TextField(
          controller: username_c,
          decoration: InputDecoration(
            hintText: 'username',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextField(
          controller: nama_lengkap_c,
          decoration: InputDecoration(
            hintText: 'nama lengkap',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextField(
          controller: email_c,
          decoration: InputDecoration(
            hintText: 'email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        TextField(
          controller: no_hp_c,
          decoration: InputDecoration(
            hintText: 'no hp',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        TextField(
          controller: password_c,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
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
              // validate first
              ErrorStatus err = _validate(
                  username: username_c.text,
                  namaLengkap: nama_lengkap_c.text,
                  email: email_c.text,
                  no_hp: no_hp_c.text,
                  password: password_c.text);
              String message = "";
              switch (err) {
                case ErrorStatus.shortUsername:
                  message = "Username minimal 6 karakter, tanpa simbol";
                  break;
                case ErrorStatus.shortName:
                  message = "Nama lengkap minimal 6 karakter";
                  break;
                case ErrorStatus.invalidPhone:
                  message = "Nomor HP tidak valid";
                  break;
                case ErrorStatus.invalidEmail:
                  message = "Email tidak valid";
                  break;
                case ErrorStatus.weakPassword:
                  message =
                      "Password minimal 8 karakter, 1 huruf lowercase, 1 huruf uppercase, dan 1 angka";
                  break;
                case ErrorStatus.none:
                  message = "valid";
                  break;
                default:
                  message = "unhandled ErrorStatus";
                  break;
              }
              if (err != ErrorStatus.none) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
                return;
              }

              try {
                await FireAuth.register(
                    username: username_c.text,
                    namaLengkap: nama_lengkap_c.text,
                    email: email_c.text,
                    no_hp: no_hp_c.text,
                    password: password_c.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Registrasi berhasil. Silahkan login")));
                await Future.delayed(Duration(milliseconds: 500), () {
                  Get.back();
                });
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "username-already-in-use":
                    message = "Username telah digunakan";
                    break;
                  case "email-already-in-use":
                    message = "Email telah digunakan";
                    break;
                  case "phone-already-in-use":
                    message = "Nomor HP telah digunakan";
                    break;
                  default:
                    message = e.code;
                    break;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              }
            },
            child: Text("Register"),
          ),
        )
      ],
      bottomChild: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Login"),
          ),
        ),
        const Text("Sudah Punya Akun ?")
      ],
    ));
  }
}
