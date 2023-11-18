import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Services/firestore_service.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';

final authServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());

final firestoreProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

final fetchUsers = FutureProvider<List<MyUser>>((ref) async {
  return await ref.read(firestoreProvider).fetchUserList();
});

final isUsernameNotAvailableProv = StateProvider<bool>((ref) => false);
