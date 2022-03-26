import 'package:flutter/material.dart';
import '../../widget/cinematix_home.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CinematixHome(filmList: [Text("test1"), Text("Test2")]),
    );
  }
}
