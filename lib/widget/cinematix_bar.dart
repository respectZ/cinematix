import 'package:cinematix/page/camera/scan_qr.dart';
import 'package:cinematix/model/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CinematixBar extends StatefulWidget {
  const CinematixBar({Key? key}) : super(key: key);

  @override
  State<CinematixBar> createState() => _CinematixBarState();
}

class _CinematixBarState extends State<CinematixBar> {
  int _currentIndex = 0;
  String text = 'Home';

  _onTap(int index) async {
    switch (index) {
      case 0:
        setState(() => text = 'Home');
        _currentIndex = 0;

        break;
      case 1:
        setState(() => text = 'Favorite');
        _currentIndex = 1;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ScanQr()));
        break;
      case 2:
        setState(() => text = 'Profile');
        Get.toNamed("/profile/ticket");
        _currentIndex = 2;
        break;
      case 3:
        setState(() => text = 'Settings');
        _currentIndex = 3;
        await showMenu(
          context: context,
          color: Color.fromARGB(255, 0, 166, 232),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          position: const RelativeRect.fromLTRB(1000.0, 525.0, 0.0, 0.0),
          items: [
            const PopupMenuItem(
              child: Text(
                "Setting",
                style: TextStyle(color: Colors.white),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                await FireAuth.signOut();
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    Get.offAndToNamed("/login");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Terdapat kesalahan.")));
                  }
                });
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem(
              child: Text("Panduan", style: TextStyle(color: Colors.white)),
            ),
          ],
          elevation: 5.0,
        );
        break;
      default:
        setState(() => text = 'Home');
    }
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
                onTap: _onTap,
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
                      icon: Icon(Icons.list, size: 30), label: "more")
                ],
                backgroundColor: const Color.fromARGB(255, 0, 166, 232))));
  }
}
