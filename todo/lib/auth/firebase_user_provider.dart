import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TodoFirebaseUser {
  TodoFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TodoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TodoFirebaseUser> todoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TodoFirebaseUser>((user) => currentUser = TodoFirebaseUser(user));
