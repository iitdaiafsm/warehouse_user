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
    apiKey: 'AIzaSyBVSY1jLgDAcSJup7LEzJUOdbEuKx8b4II',
    appId: '1:672642896943:web:c0c5aac6df6a4bfc8022da',
    messagingSenderId: '672642896943',
    projectId: 'smart-warehouse-b3713',
    authDomain: 'smart-warehouse-b3713.firebaseapp.com',
    storageBucket: 'smart-warehouse-b3713.appspot.com',
    measurementId: 'G-Z97SS0B3ZE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgmjf_Z1d14gzMAHWZtlU4dgoyQAvCB4s',
    appId: '1:672642896943:android:5b00254726e285248022da',
    messagingSenderId: '672642896943',
    projectId: 'smart-warehouse-b3713',
    storageBucket: 'smart-warehouse-b3713.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGG-9koCqSCQazqxd9henGuPTuELIyME0',
    appId: '1:672642896943:ios:e7ec5f914d625d548022da',
    messagingSenderId: '672642896943',
    projectId: 'smart-warehouse-b3713',
    storageBucket: 'smart-warehouse-b3713.appspot.com',
    iosClientId: '672642896943-8p00huusvromsc5blnqui5nlo99svio3.apps.googleusercontent.com',
    iosBundleId: 'com.fsm.warehouseUser',
  );
}
