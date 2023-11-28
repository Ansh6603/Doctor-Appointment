// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCtd6U_ppYZs87zZdYMkxGNVDaCBv-TOOA',
    appId: '1:484981138953:web:b4dbfa21b9585faa677ad8',
    messagingSenderId: '484981138953',
    projectId: 'health-686ab',
    authDomain: 'health-686ab.firebaseapp.com',
    storageBucket: 'health-686ab.appspot.com',
    measurementId: 'G-JE6NTB43FL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMOgyBLay5oG-IjdHkwc5YKmLz5gh0Jbs',
    appId: '1:484981138953:android:7e2608756e6bf31b677ad8',
    messagingSenderId: '484981138953',
    projectId: 'health-686ab',
    storageBucket: 'health-686ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBacxv4nCy9j6rYyMoRiQ0cuZ-7WdAZA30',
    appId: '1:484981138953:ios:9874644882fe0d74677ad8',
    messagingSenderId: '484981138953',
    projectId: 'health-686ab',
    storageBucket: 'health-686ab.appspot.com',
    iosBundleId: 'com.example.doctorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBacxv4nCy9j6rYyMoRiQ0cuZ-7WdAZA30',
    appId: '1:484981138953:ios:2bb2feabd39ed145677ad8',
    messagingSenderId: '484981138953',
    projectId: 'health-686ab',
    storageBucket: 'health-686ab.appspot.com',
    iosBundleId: 'com.example.doctorApp.RunnerTests',
  );
}