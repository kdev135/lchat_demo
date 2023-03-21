
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:lchat/siri.dart';


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:944556294032:android:d473b978e1f9df40cbfd15',
    messagingSenderId: '944556294032',
    projectId: 'longevity-chat',
    storageBucket: 'longevity-chat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:944556294032:ios:61495bf18a88e950cbfd15',
    messagingSenderId: '944556294032',
    projectId: 'longevity-chat',
    storageBucket: 'longevity-chat.appspot.com',
    iosClientId: '944556294032-e41ed5qalmr264i22a2su1q9h0iva3cv.apps.googleusercontent.com',
    iosBundleId: 'org.longevity.chat.lchat',
  );
}
