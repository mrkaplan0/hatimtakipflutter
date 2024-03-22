// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Services/firestore_service.dart';
import 'package:hatimtakipflutter/Viewmodels/individualpage_viewmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/parts_viewmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';
import 'package:uuid/uuid.dart';

//homepage tabview index provider
final navigationIndexProvider = StateProvider<int>((ref) => 0);

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

// for tabview in hatim settings
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
final fetchHatims = StreamProvider<List<Hatim>>((ref) => ref
    .watch(firestoreProvider)
    .readHatimList(ref.read(userViewModelProvider).user!));

// for fetching parts of Hatim
final fetchHatimParts =
    StateProviderFamily<List<HatimPartModel>, Hatim>((ref, hatim) {
  return hatim.partsOfHatimList;
});

// for fetching user`s parts
final getMyIndividualParts = StateProvider<List<HatimPartModel>>((ref) {
  List<HatimPartModel> myIndiviParts = [];
  var myUser = ref.read(userViewModelProvider).user;
  var hatimList = ref.watch(fetchHatims).value;

  if (hatimList != null) {
    for (var hatim in hatimList) {
      for (var part in hatim.partsOfHatimList) {
        if (part.ownerOfPart?.id == myUser?.id) {
          myIndiviParts.add(part);
        }
      }
    }
    myIndiviParts.sort((a, b) => a.pages.first.compareTo(b.pages.first));
  }

  return myIndiviParts;
});

//in individual Page to activate undo button if page is deleted.
final butnActvateListProv =
    StateNotifierProvider.family.autoDispose<IndiviPageViewModel, bool, int>(
  (ref, arg) {
    return IndiviPageViewModel(false);
  },
);

final updateRemainingPagesProv =
    AutoDisposeFutureProviderFamily<bool, HatimPartModel>((ref, part) async =>
        await ref.read(firestoreProvider).updateRemainingPages(part));

final onlyPublicHatims = StreamProvider<List<Hatim>>(
    (ref) => ref.watch(firestoreProvider).fetchOnlyPublicHatims());
