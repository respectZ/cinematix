import 'package:flutter/material.dart';
import 'cinematix_bar.dart';

class CinematixHome extends StatefulWidget {
  List<Widget> filmList = [];

  CinematixHome({Key? key, required this.filmList}) : super(key: key);

  @override
  _CinematixHomeState createState() => _CinematixHomeState();
}

class _CinematixHomeState extends State<CinematixHome> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CINEMATIX",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Artline660",
                style: TextStyle(color: Colors.black87),
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black87,
            ),
            iconSize: 20,
          )
        ],
      ),
      body: Stack(children: [
        Container(
          child: Row(
            children: widget.filmList,
          ),
        )
      ]),
      bottomNavigationBar: const CinematixBar(),
    );
  }
}
