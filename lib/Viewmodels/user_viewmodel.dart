import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Services/delegate/auth_delegate.dart';
import 'package:hatimtakipflutter/Services/delegate/database_delegate.dart';

final userViewModelProvider = Provider<UserViewModel>((ref) {
  return UserViewModel();
});

final userProvider = Provider<MyUser?>((ref) {
  return ref.watch(userViewModelProvider)._myUser;
});

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements MyAuthenticationDelegate {
  ViewState _state = ViewState.Idle;
  MyUser? _myUser;
  FirebaseAuthService authService = FirebaseAuthService();

  UserViewModel() {
    currentUser();
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
      state = ViewState.Busy;
      _myUser = await authService.currentUser();
      if (_myUser != null) {
        return _myUser;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata: $e");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      state = ViewState.Busy;
      _myUser = await authService.createUserWithEmailAndPassword(
          email, password, username);
      return _myUser;
    } catch (e) {
      debugPrint("Viewmodeldeki create user hata: $e");
    }
  }

  @override
  Future<MyUser?> signInWithAnonymously() async {
    // TODO: implement signInWithAnonymously
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
