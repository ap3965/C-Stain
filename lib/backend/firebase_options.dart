// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDd3etXEMoEnQeHdhLarYIYE9Q4rt3M1Pw',
    appId: '1:341493656655:web:710826247b9603375a0e3a',
    messagingSenderId: '341493656655',
    projectId: 'cstain-a5fd8',
    authDomain: 'cstain-a5fd8.firebaseapp.com',
    storageBucket: 'cstain-a5fd8.appspot.com',
    measurementId: 'G-BKGJ5VWSSS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwh5ePQ-w_N1iAJlkfrejhkGi7jYi_Wd0',
    appId: '1:341493656655:android:98d00bcdb32c3c2e5a0e3a',
    messagingSenderId: '341493656655',
    projectId: 'cstain-a5fd8',
    storageBucket: 'cstain-a5fd8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAADMggclhh4ms2XKqVVsRQR9sm-xMQvk0',
    appId: '1:341493656655:ios:4b708620e3e947f65a0e3a',
    messagingSenderId: '341493656655',
    projectId: 'cstain-a5fd8',
    storageBucket: 'cstain-a5fd8.appspot.com',
    iosBundleId: 'com.example.cstain',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAADMggclhh4ms2XKqVVsRQR9sm-xMQvk0',
    appId: '1:341493656655:ios:4b708620e3e947f65a0e3a',
    messagingSenderId: '341493656655',
    projectId: 'cstain-a5fd8',
    storageBucket: 'cstain-a5fd8.appspot.com',
    iosBundleId: 'com.example.cstain',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDd3etXEMoEnQeHdhLarYIYE9Q4rt3M1Pw',
    appId: '1:341493656655:web:32aa118f3adc3b155a0e3a',
    messagingSenderId: '341493656655',
    projectId: 'cstain-a5fd8',
    authDomain: 'cstain-a5fd8.firebaseapp.com',
    storageBucket: 'cstain-a5fd8.appspot.com',
    measurementId: 'G-9929MQZLDD',
  );
}
