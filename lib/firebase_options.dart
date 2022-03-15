// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBxtYWsnan8NOmAOV9-pUYt8tpaIatr76g',
    appId: '1:1053495375688:web:eb2b9027caaab1fdf3a57d',
    messagingSenderId: '1053495375688',
    projectId: 'cinematix-2e6bc',
    authDomain: 'cinematix-2e6bc.firebaseapp.com',
    storageBucket: 'cinematix-2e6bc.appspot.com',
    measurementId: 'G-T9L912QG6K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhh-YVnt6DtptGelRvygNPcQvSV0dscuU',
    appId: '1:1053495375688:android:ef8bcc8a5eb13ca9f3a57d',
    messagingSenderId: '1053495375688',
    projectId: 'cinematix-2e6bc',
    storageBucket: 'cinematix-2e6bc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYxbcRs4Rw4AL2TAdiX9lTi3GydhPbWU8',
    appId: '1:1053495375688:ios:afb924aff1806ea9f3a57d',
    messagingSenderId: '1053495375688',
    projectId: 'cinematix-2e6bc',
    storageBucket: 'cinematix-2e6bc.appspot.com',
    iosClientId: '1053495375688-koampohvjcivkci5jpbagknou52rjm63.apps.googleusercontent.com',
    iosBundleId: 'com.afive.cinematix',
  );
}
