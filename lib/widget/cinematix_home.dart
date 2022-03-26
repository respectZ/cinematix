import 'package:flutter/material.dart';

class CinematixHome extends StatefulWidget {
  List<Widget> filmList = [];

  CinematixHome({Key? key, required this.filmList}) : super(key: key);

  @override
  _CinematixHomeState createState() => _CinematixHomeState();
}

class _CinematixHomeState extends State<CinematixHome> {
  int _currentIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  final List<Widget> _children = [
    const Text(
      "Home",
      style: optionStyle,
    ),
    const Text(
      "Qrcode",
      style: optionStyle,
    ),
    const Text(
      "Ticket",
      style: optionStyle,
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey[300],
                    currentIndex: _currentIndex,
                    onTap: onTabTapped,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_sharp,
                            size: 30,
                          ),
                          label: "home"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.qr_code_sharp,
                            size: 30,
                          ),
                          label: "qrcode"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.airplane_ticket_sharp,
                            size: 30,
                          ),
                          label: "ticket"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.list,
                            size: 40,
                          ),
                          label: "more")
                    ],
                    backgroundColor: Color.fromARGB(255, 0, 166, 232)))));
  }
}
