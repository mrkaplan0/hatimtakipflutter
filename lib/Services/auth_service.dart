import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/delegate/auth_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

class FirebaseAuthService implements MyAuthenticationDelegate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? myUser;

  MyUser _usersFromFirebase(User user) {
    return MyUser(
        id: user.uid,
        email: user.email ?? "",
        username: user.displayName ?? "");
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      User? user = _auth.currentUser;

      return _usersFromFirebase(user!);
    } catch (e) {
      debugPrint("Hata CurrentUser $e");
      return null;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    UserCredential sonuc = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await sonuc.user?.updateDisplayName(username);
    return _usersFromFirebase(sonuc.user!);
  }

  @override
  Future<MyUser?> signInWithAnonymously() async {
    UserCredential sonuc = await _auth.signInAnonymously();
    return _usersFromFirebase(sonuc.user!);
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential sonuc = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return _usersFromFirebase(sonuc.user!);
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint("Hata SignOut $e");
      return false;
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Hata SignOut $e");
      return false;
    }
  }
}
