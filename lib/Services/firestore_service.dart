import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Services/delegate/database_delegate.dart';

class FirestoreService implements MyDatabaseDelegate {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<bool> saveMyUser(MyUser user) async {
    try {
      await db
          .collection('Users')
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<MyUser?> readMyUser(String userId) async {
    MyUser? user;
    try {
      DocumentSnapshot okunanUser =
          await db.collection('Users').doc(userId).get();

      user = MyUser.fromJson(okunanUser.data() as Map<String, dynamic>);

      debugPrint("Okunan user nesnesi $user");
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Future<List<MyUser>> fetchUserList() async {
    List<MyUser> userList = [];
    try {
      QuerySnapshot docs = await db.collection("Users").get();

      for (var user in docs.docs) {
        MyUser u = MyUser.fromJson(user.data() as Map<String, dynamic>);

        userList.add(u);
      }
    } catch (e) {
      print(e);
    }

    return userList;
  }

  @override
  Future<List<MyUser>> fetchfavoritesPeopleList(MyUser user) async {
    List<MyUser> favoritesPeopleList = [];
    try {
      var docs = await db
          .collection('Users')
          .doc(user.id)
          .collection('favoritesPeople')
          .get();
      for (var user in docs.docs) {
        MyUser u = MyUser.fromJson(user.data());
        favoritesPeopleList.add(u);
      }
    } catch (error) {
      print(error);
    }
    return favoritesPeopleList;
  }

  @override
  Future<bool> createNewHatim(Hatim newHatim) async {
    final docRefPrivateList =
        db.collection('Hatimler').doc('MainLists').collection('PrivateLists');
    final docRefPublicList =
        db.collection('Hatimler').doc('MainLists').collection('PublicLists');
    try {
      if (newHatim.isPrivate == true) {
        await docRefPrivateList
            .doc(newHatim.id)
            .set(newHatim.toJson(), SetOptions(merge: true));
        for (var usr in newHatim.participantsList) {
          await docRefPrivateList
              .doc(newHatim.id)
              .collection('Participants')
              .doc(usr.id)
              .set(usr.toJson(), SetOptions(merge: true));
        }
        for (var i = 0; i < newHatim.partsOfHatimList.length; i++) {
          await docRefPrivateList
              .doc(newHatim.id)
              .collection('Parts')
              .doc(newHatim.partsOfHatimList[i].id)
              .set(newHatim.partsOfHatimList[i].toJson());
        }
      } else {
        await docRefPublicList
            .doc(newHatim.id)
            .set(newHatim.toJson(), SetOptions(merge: true));
        for (var usr in newHatim.participantsList) {
          await docRefPublicList
              .doc(newHatim.id)
              .collection('Participants')
              .doc(usr.id)
              .set(usr.toJson(), SetOptions(merge: true));
          await db
              .collection('Users')
              .doc(newHatim.createdBy?.id)
              .collection('favoritesPeople')
              .doc(usr.id)
              .set(usr.toJson(), SetOptions(merge: true));
        }
        for (var i = 0; i < newHatim.partsOfHatimList.length; i++) {
          await docRefPublicList
              .doc(newHatim.id)
              .collection('Parts')
              .doc(newHatim.partsOfHatimList[i].id)
              .set(newHatim.partsOfHatimList[i].toJson());
        }
      }
    } catch (error) {
      print(error);
    }
    return true;
  }

  @override
  Future<List<Hatim>> readHatimList(MyUser user) async {
    Set<Hatim> hatimList = {};
    var docRefPrivateList =
        db.collection("Hatimler").doc("MainLists").collection("PrivateLists");
    var docRefPublicList =
        db.collection("Hatimler").doc("MainLists").collection("PublicLists");

    try {
      var querySnap = await docRefPrivateList
          .where("participantsList", arrayContains: user.toJson())
          .get();

      for (var doc in querySnap.docs) {
        var hatim = Hatim.fromJson(doc.data());

        hatimList.add(hatim);
      }
    } catch (error) {
      print(error);
    }

    try {
      var querySnap = await docRefPublicList
          .where("participantsList", arrayContains: user.toJson())
          .get();

      for (var doc in querySnap.docs) {
        var hatim = Hatim.fromJson(doc.data());

        hatimList.add(hatim);
      }
    } catch (error) {
      print(error);
    }

    return hatimList.toList();
  }

  @override
  Future<bool> deleteHatim(Hatim hatim) async {
    final docRefPrivateList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PrivateLists");
    final docRefPublicList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PublicLists");

    try {
      if (hatim.isPrivate == true) {
        await docRefPrivateList.doc(hatim.id).delete();
      } else {
        await docRefPublicList.doc(hatim.id).delete();
      }
    } catch (error) {
      print(error);
      return false;
    }
    return true;
  }

  @override
  Future<List<HatimPartModel>> fetchHatimParts(Hatim hatim) async {
    List<HatimPartModel> partslist = [];
    final docRefPrivateList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PrivateLists");
    final docRefPublicList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PublicLists");

    try {
      if (hatim.isPrivate == true) {
        final querySnap =
            await docRefPrivateList.doc(hatim.id).collection("Parts").get();
        for (var doc in querySnap.docs) {
          final part = HatimPartModel.fromJson(doc.data());
          partslist.add(part);
        }
      } else {
        final querySnap =
            await docRefPublicList.doc(hatim.id).collection("Parts").get();
        for (var doc in querySnap.docs) {
          final part = HatimPartModel.fromJson(doc.data());
          partslist.add(part);
        }
      }
    } catch (error) {
      print(error);
    }

    return partslist;
  }

  @override
  Future<bool> updateOwnerOfPart(MyUser newOwner, HatimPartModel part) async {
    final docRefPrivateList =
        db.collection('Hatimler').doc('MainLists').collection('PrivateLists');
    final docRefPublicList =
        db.collection('Hatimler').doc('MainLists').collection('PublicLists');
    try {
      final userDict = newOwner.toJson();
      if (part.isPrivate == true) {
        await docRefPrivateList
            .doc(part.hatimID)
            .collection('Parts')
            .doc(part.id)
            .update({'ownerOfPart': userDict});
      } else {
        await docRefPublicList
            .doc(part.hatimID)
            .collection('Parts')
            .doc(part.id)
            .update({'ownerOfPart': userDict});
      }
    } catch (error) {
      print(error);
    }
    return true;
  }

  @override
  Future<List<HatimPartModel>> fetchIndividualParts(
      List<Hatim> hatimList, MyUser myUser) async {
    List<HatimPartModel> partslist = [];
    final docRefPrivateList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PrivateLists");
    final docRefPublicList = FirebaseFirestore.instance
        .collection("Hatimler")
        .doc("MainLists")
        .collection("PublicLists");

    try {
      for (var hatim in hatimList) {
        if (hatim.isPrivate == true) {
          final querySnap = await docRefPrivateList
              .doc(hatim.id)
              .collection("Parts")
              .where("ownerOfPart", isEqualTo: myUser.toJson())
              .get();
          for (var doc in querySnap.docs) {
            final part = HatimPartModel.fromJson(doc.data());
            partslist.add(part);
          }
        } else {
          final querySnap = await docRefPublicList
              .doc(hatim.id)
              .collection("Parts")
              .where("ownerOfPart", isEqualTo: myUser.toJson())
              .get();
          for (var doc in querySnap.docs) {
            final part = HatimPartModel.fromJson(doc.data());
            partslist.add(part);
          }
        }
      }
    } catch (error) {
      return [];
    }
    print(" db calisti");
    partslist.sort((a, b) => a.pages.first.compareTo(b.pages.first));
    return partslist;
  }

  @override
  Future<bool> updateRemainingPages(HatimPartModel part) async {
    final docRefPrivateList =
        db.collection('Hatimler').doc('MainLists').collection('PrivateLists');
    final docRefPublicList =
        db.collection('Hatimler').doc('MainLists').collection('PublicLists');
    try {
      if (part.isPrivate == true) {
        await docRefPrivateList
            .doc(part.hatimID)
            .collection('Parts')
            .doc(part.id)
            .update({'remainingPages': part.remainingPages});
      } else {
        await docRefPublicList
            .doc(part.hatimID)
            .collection('Parts')
            .doc(part.id)
            .update({'remainingPages': part.remainingPages});
      }
    } catch (error) {
      return false;
    }
    return true;
  }

  @override
  Future<List<Hatim>> fetchOnlyPublicHatims() async {
    Set<Hatim> hatimList = <Hatim>{};
    final docRefPublicList =
        db.collection('Hatimler').doc('MainLists').collection('PublicLists');
    try {
      final querySnap = await docRefPublicList.get();
      for (final doc in querySnap.docs) {
        final hatim = Hatim.fromJson(doc.data());
        for (final part in hatim.partsOfHatimList) {
          if (part.ownerOfPart == null) {
            hatimList.add(hatim);
            break;
          }
        }
      }
    } catch (error) {
      print(error);
    }
    return hatimList.toList();
  }

  @override
  Future<List<HatimPartModel>> fetchOnlyFreiPartsOfPublicHatims(
      Hatim hatim) async {
    var partslist = <HatimPartModel>[];
    final docRefPublicList =
        db.collection('Hatimler').doc('MainLists').collection('PublicLists');
    try {
      final querySnap =
          await docRefPublicList.doc(hatim.id).collection('Parts').get();
      for (final doc in querySnap.docs) {
        final part = HatimPartModel.fromJson(doc.data());
        if (part.ownerOfPart == null) {
          partslist.add(part);
        }
      }
    } catch (error) {
      print(error);
    }
    return partslist;
  }
}
