import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBqJJQKqJQKqJQKqJQKqJQKqJQKqJQKqJQ',
    appId: '1:123456789:web:abcdef123456789',
    messagingSenderId: '123456789',
    projectId: 'formphonix',
    authDomain: 'formphonix.firebaseapp.com',
    storageBucket: 'formphonix.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqJJQKqJQKqJQKqJQKqJQKqJQKqJQKqJQ',
    appId: '1:123456789:android:abcdef123456789',
    messagingSenderId: '123456789',
    projectId: 'formphonix',
    storageBucket: 'formphonix.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqJJQKqJQKqJQKqJQKqJQKqJQKqJQKqJQ',
    appId: '1:123456789:ios:abcdef123456789',
    messagingSenderId: '123456789',
    projectId: 'formphonix',
    storageBucket: 'formphonix.appspot.com',
    iosBundleId: 'com.example.phonixform',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqJJQKqJQKqJQKqJQKqJQKqJQKqJQKqJQ',
    appId: '1:123456789:ios:abcdef123456789',
    messagingSenderId: '123456789',
    projectId: 'formphonix',
    storageBucket: 'formphonix.appspot.com',
    iosBundleId: 'com.example.phonixform',
  );
}
