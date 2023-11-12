import 'package:hatimtakipflutter/Models/myuser.dart';

abstract class MyAuthenticationDelegate {
  Future<MyUser?> currentUser();
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password, String username);
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<MyUser?> signInWithAnonymously();
  Future<bool> signOut();
}
