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
    apiKey: 'AIzaSyC60wxJjoEuAir1xlle3-cRm2yJd2zIjOU',
    appId: '1:492272218176:web:74130287b004fc6c0d6fa5',
    messagingSenderId: '492272218176',
    projectId: 'formphonix',
    authDomain: 'formphonix.firebaseapp.com',
    storageBucket: 'formphonix.firebasestorage.app',
    measurementId: 'G-R9MQKQTFYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnp312Z7eVIc2iE4-9VV_MCv_VocBIdSw',
    appId: '1:492272218176:android:97038a30f08aa5ac0d6fa5',
    messagingSenderId: '492272218176',
    projectId: 'formphonix',
    storageBucket: 'formphonix.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoAsGNM-vZSx45v-P8vI9qwhhS1LxdOhM',
    appId: '1:492272218176:ios:a58516af9abc15610d6fa5',
    messagingSenderId: '492272218176',
    projectId: 'formphonix',
    storageBucket: 'formphonix.firebasestorage.app',
    androidClientId: '492272218176-qvljc361kjo4tdc83mgs55puspfpfob7.apps.googleusercontent.com',
    iosClientId: '492272218176-fu5k72r2pil5n1r74csnvqa03lkb4i7i.apps.googleusercontent.com',
    iosBundleId: 'com.example.phonixform',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoAsGNM-vZSx45v-P8vI9qwhhS1LxdOhM',
    appId: '1:492272218176:ios:a58516af9abc15610d6fa5',
    messagingSenderId: '492272218176',
    projectId: 'formphonix',
    storageBucket: 'formphonix.firebasestorage.app',
    androidClientId: '492272218176-qvljc361kjo4tdc83mgs55puspfpfob7.apps.googleusercontent.com',
    iosClientId: '492272218176-fu5k72r2pil5n1r74csnvqa03lkb4i7i.apps.googleusercontent.com',
    iosBundleId: 'com.example.phonixform',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC60wxJjoEuAir1xlle3-cRm2yJd2zIjOU',
    appId: '1:492272218176:web:d9bccf5e895adb860d6fa5',
    messagingSenderId: '492272218176',
    projectId: 'formphonix',
    authDomain: 'formphonix.firebaseapp.com',
    storageBucket: 'formphonix.firebasestorage.app',
    measurementId: 'G-R7XKRDW35P',
  );

}