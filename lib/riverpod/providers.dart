import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Services/firestore_service.dart';
import 'package:hatimtakipflutter/Viewmodels/parts_viewmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';
import 'package:uuid/uuid.dart';

final authServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());

final firestoreProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

final fetchUsers = FutureProvider<List<MyUser>>((ref) async {
  return await ref.read(firestoreProvider).fetchUserList();
});

final isUsernameNotAvailableProv = StateProvider<bool>((ref) => false);

final pageControllerProv = Provider<PageController>((ref) => PageController());
final myPageController =
    StateProvider<PageController>((ref) => ref.read(pageControllerProv));

final newHatimProvider = StateProvider<Hatim>((ref) => Hatim(
    id: const Uuid().v4().toString(),
    participantsList: [],
    partsOfHatimList: []));

final hatimPartsProvider =
    ChangeNotifierProvider((ref) => PartsOfHatimViewModel());
