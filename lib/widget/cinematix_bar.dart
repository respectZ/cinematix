import 'package:flutter/material.dart';

class CinematixBar extends StatefulWidget {
  const CinematixBar({Key? key}) : super(key: key);

  @override
  State<CinematixBar> createState() => _CinematixBarState();
}

class _CinematixBarState extends State<CinematixBar> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
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
                backgroundColor: Color.fromARGB(255, 0, 166, 232))));
  }
}
