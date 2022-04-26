import 'package:cinematix/model/voucher.dart';
import 'package:cinematix/page/favorit_saya/favorit_saya.dart';
import 'package:cinematix/page/voucher_saya/voucher_saya.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'package:cinematix/page/login.dart';
import 'package:cinematix/page/register.dart';
import 'package:cinematix/page/main_menu/main_menu.dart';
import 'package:cinematix/page/movie/movie_detail.dart';
import 'package:cinematix/page/movie/movie_ticket.dart';
import 'package:cinematix/page/profil/profil.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CINEMATIX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
      ),
      home: const MainApp(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/main', page: () => MainMenu()),
        GetPage(name: '/profile', page: () => Profil()),
        GetPage(name: '/profile/voucher', page: () => VoucherSaya()),
        GetPage(name: '/profile/favorite', page: () => FavoritSaya()),
        GetPage(name: '/movie_detail', page: () => MovieDetailPage()),
        GetPage(name: '/movie_ticket', page: () => MovieTicketPage()),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
