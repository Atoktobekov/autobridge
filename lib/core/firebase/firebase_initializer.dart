import 'package:autobridge/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer {
  static FirebaseOptions? get options {
    return DefaultFirebaseOptions.currentPlatform;
  }
}
