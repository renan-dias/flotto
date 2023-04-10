import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBUFYHWYqjZYbZndg6a1ORMSHBrIK4yfuU",
            authDomain: "flottogram.firebaseapp.com",
            projectId: "flottogram",
            storageBucket: "flottogram.appspot.com",
            messagingSenderId: "149407890585",
            appId: "1:149407890585:web:86bba853575b5c52d14c08",
            measurementId: "G-Z2GKWK6SJP"));
  } else {
    await Firebase.initializeApp();
  }
}
