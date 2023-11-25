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

final firestoreProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

//user model
final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());

//fetch users for adding username or add user to hatim
final fetchUsers = FutureProvider<List<MyUser>>((ref) async {
  return await ref.read(firestoreProvider).fetchUserList();
});

final isUsernameNotAvailableProv = StateProvider<bool>((ref) => false);

// for tabview in homepage.dart
final pageControllerProv = Provider<PageController>((ref) => PageController());
final myPageController =
    StateProvider<PageController>((ref) => ref.read(pageControllerProv));

// for creating new Hatim
final newHatimProvider = StateProvider<Hatim>((ref) => Hatim(
    id: const Uuid().v4().toString(),
    participantsList: [],
    partsOfHatimList: []));

// for creating parts for hatim
final hatimPartsProvider =
    ChangeNotifierProvider((ref) => PartsOfHatimViewModel());

// for fetching Hatims
final fetchHatims = FutureProvider<List<Hatim>>((ref) async => await ref
    .read(firestoreProvider)
    .readHatimList(ref.read(userViewModelProvider).user!));

final fetchHatimParts = FutureProviderFamily<List<HatimPartModel>, Hatim>(
    (ref, hatim) async =>
        await ref.read(firestoreProvider).fetchHatimParts(hatim));
