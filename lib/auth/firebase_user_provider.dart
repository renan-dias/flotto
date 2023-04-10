import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FlottoFirebaseUser {
  FlottoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FlottoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FlottoFirebaseUser> flottoFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FlottoFirebaseUser>(
      (user) {
        currentUser = FlottoFirebaseUser(user);
        return currentUser!;
      },
    );
