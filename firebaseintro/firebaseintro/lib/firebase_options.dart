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
    apiKey: 'AIzaSyAJBJAhWlT1SxHcBI7c_hsTES4wb-5ACks',
    appId: '1:276220036417:web:f0819fa9483e0992990dc0',
    messagingSenderId: '276220036417',
    projectId: 'tobeto-3439c',
    authDomain: 'tobeto-3439c.firebaseapp.com',
    storageBucket: 'tobeto-3439c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8R4hKsiMGvlDzxz_7CPHyTWYI56EtyOA',
    appId: '1:276220036417:android:187ffbc195bff8b9990dc0',
    messagingSenderId: '276220036417',
    projectId: 'tobeto-3439c',
    storageBucket: 'tobeto-3439c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQ0YzJNyeZvO9sh5PjmzP4gBqwery2x3c',
    appId: '1:276220036417:ios:7a4d3470e62137e0990dc0',
    messagingSenderId: '276220036417',
    projectId: 'tobeto-3439c',
    storageBucket: 'tobeto-3439c.appspot.com',
    iosBundleId: 'com.example.firebaseintro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQ0YzJNyeZvO9sh5PjmzP4gBqwery2x3c',
    appId: '1:276220036417:ios:7a4d3470e62137e0990dc0',
    messagingSenderId: '276220036417',
    projectId: 'tobeto-3439c',
    storageBucket: 'tobeto-3439c.appspot.com',
    iosBundleId: 'com.example.firebaseintro',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAJBJAhWlT1SxHcBI7c_hsTES4wb-5ACks',
    appId: '1:276220036417:web:76359b07bb636542990dc0',
    messagingSenderId: '276220036417',
    projectId: 'tobeto-3439c',
    authDomain: 'tobeto-3439c.firebaseapp.com',
    storageBucket: 'tobeto-3439c.appspot.com',
  );
}
