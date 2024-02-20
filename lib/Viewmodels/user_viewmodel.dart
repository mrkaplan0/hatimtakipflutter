import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Services/delegate/auth_delegate.dart';
import 'package:hatimtakipflutter/Services/firestore_service.dart';

enum ViewState { idle, busy }

class UserViewModel with ChangeNotifier implements MyAuthenticationDelegate {
  ViewState _state = ViewState.idle;
  MyUser? _myUser;
  FirebaseAuthService authService = FirebaseAuthService();
  FirestoreService firestoreService = FirestoreService();

  UserViewModel() {
    currentUser().then((value) => debugPrint("current user"));
  }

  MyUser? get user => _myUser;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      state = ViewState.busy;
      _myUser = await authService.currentUser();
      if (_myUser != null) {
        _myUser = await firestoreService.readMyUser(_myUser!.id);

        return _myUser;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata: $e");
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      state = ViewState.busy;
      _myUser = await authService.createUserWithEmailAndPassword(
          email, password, username);

      if (_myUser != null) {
        _myUser?.username = username;
        bool result = await firestoreService.saveMyUser(_myUser!);

        if (result == true) {
          _myUser = await firestoreService.readMyUser(_myUser!.id);
        }
      }
    } catch (e) {
      debugPrint("Viewmodeldeki create user hata: $e");
    } finally {
      state = ViewState.idle;
    }
    return _myUser;
  }

  @override
  Future<MyUser?> signInWithAnonymously() async {
    try {
      state = ViewState.busy;
      _myUser = await authService.signInWithAnonymously();
      if (_myUser != null) {
        bool result = await firestoreService.saveMyUser(_myUser!);

        if (result == true) {
          _myUser = await firestoreService.readMyUser(_myUser!.id);
        }
      }
      return _myUser;
    } catch (e) {
      debugPrint("User Model signin error :$e");
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      state = ViewState.busy;
      _myUser = await authService.signInWithEmailAndPassword(email, password);
      if (_myUser != null) {
        _myUser = await firestoreService.readMyUser(_myUser!.id);
      }
      return _myUser;
    } catch (e) {
      debugPrint("User Model signin error :$e");
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.busy;
      bool sonuc = await authService.signOut();

      _myUser = null;

      return sonuc;
    } catch (e) {
      debugPrint("User Model signout error :$e");
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      state = ViewState.busy;
      bool sonuc = await authService.resetPassword(email);

      _myUser = null;

      return sonuc;
    } catch (e) {
      debugPrint("User Model signout error :$e");
      return false;
    } finally {
      state = ViewState.idle;
    }
  }
}
