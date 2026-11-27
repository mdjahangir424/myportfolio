import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for the portfolio web application.
/// Keep privileged service-account credentials out of this file.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'Android Firebase options have not been configured for this web-only app.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS Firebase options have not been configured for this web-only app.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'macOS Firebase options have not been configured for this web-only app.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'Windows Firebase options have not been configured for this web-only app.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Linux Firebase options have not been configured for this web-only app.',
        );
      default:
        throw UnsupportedError('This platform is not configured for Firebase.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4Nii0SVUfU_zIGYEgPCGFJ3DcDoe7n7o',
    appId: '1:180769690234:web:2f2f061d988c4319ca61c3',
    messagingSenderId: '180769690234',
    projectId: 'myportfolio-f6cfb',
    authDomain: 'myportfolio-f6cfb.firebaseapp.com',
    storageBucket: 'myportfolio-f6cfb.firebasestorage.app',
    measurementId: 'G-TQHBLVRXDW',
  );
}
