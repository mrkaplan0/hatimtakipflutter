import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/partmodel.dart';
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
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');

    try {
      await docRefHatimList
          .doc(newHatim.id)
          .set(newHatim.toJson(), SetOptions(merge: true));

      for (var part in newHatim.partsOfHatimList) {
        await docRefHatimList
            .doc(newHatim.id)
            .collection(newHatim.id)
            .doc(newHatim.id)
            .set({part.id: part.toJson()}, SetOptions(merge: true));
      }
      for (var usr in newHatim.participantsList) {
        await db
            .collection('Users')
            .doc(newHatim.createdBy?.id)
            .collection('favoritesPeople')
            .doc(usr.id)
            .set(usr.toJson(), SetOptions(merge: true));
      }
    } catch (error) {
      return false;
    }
    return true;
  }

  @override
  Stream<List<Hatim>> readHatimList(MyUser user) {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');

    try {
      var querySnap = docRefHatimList
          .where("participantsList", arrayContains: user.toJson())
          .snapshots();

      return querySnap.map((hatimList) =>
          hatimList.docs.map((hatim) => Hatim.fromJson(hatim.data())).toList());
    } catch (error) {
      debugPrint(error.toString());
      return const Stream.empty();
    }
  }

  @override
  Future<bool> deleteHatim(Hatim hatim) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      await docRefHatimList.doc(hatim.id).delete();
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<PartModel>> fetchHatimParts(Hatim hatim) {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');

    var querySnap = docRefHatimList
        .doc(hatim.id)
        .collection(hatim.id)
        .doc(hatim.id)
        .snapshots();
    return querySnap.map((partsDoc) {
      Map<String, dynamic>? partsMap = partsDoc.data();
      List<PartModel> partsList = [];
      partsMap!.forEach((key, value) {
        partsList.add(PartModel.fromJson(value));
      });
      return partsList;
    });
  }

  @override
  Future<List<PartModel>> fetchIndividualParts(
      List<Hatim> hatimList, MyUser myUser) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    List<PartModel> individualPartsList = [];
    try {
      for (var hatim in hatimList) {
        var querySnap = await docRefHatimList
            .doc(hatim.id)
            .collection(hatim.id)
            .doc(hatim.id)
            .get();
        Map<String, dynamic> data = querySnap.data() as Map<String, dynamic>;
        var parts = data.values.map((e) => PartModel.fromJson(e));
        for (var part in parts) {
          part.ownerOfPart?.id == myUser.id
              ? individualPartsList.add(part)
              : null;
        }
      }
      return individualPartsList;
    } on Exception catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  @override
  Future<bool> updateOwnerOfPart(MyUser newOwner, PartModel part) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      part.ownerOfPart = newOwner;
      final userMap = newOwner.toJson();

      await docRefHatimList
          .doc(part.hatimID)
          .collection(part.hatimID)
          .doc(part.hatimID)
          .update({part.id: part.toJson()});

      final hatimData = await docRefHatimList.doc(part.hatimID).get();

      var newParticipantsList = hatimData.data()!["participantsList"];
      newParticipantsList.add(userMap);

      await docRefHatimList.doc(part.hatimID).update({
        "participantsList": newParticipantsList,
      });
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
    return true;
  }

  @override
  Future<bool> updateRemainingPages(PartModel part) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      await docRefHatimList
          .doc(part.hatimID)
          .collection(part.hatimID)
          .doc(part.hatimID)
          .set({part.id: part.toJson()}, SetOptions(merge: true));
    } catch (error) {
      print("errrr $error");
      return false;
    }
    return true;
  }

  @override
  Stream<List<Hatim>> fetchOnlyPublicHatims() {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      final querySnap =
          docRefHatimList.where("isPrivate", isEqualTo: false).snapshots();
      return querySnap.map((hatimList) =>
          hatimList.docs.map((hatim) => Hatim.fromJson(hatim.data())).toList());
    } catch (error) {
      debugPrint(error.toString());
      return const Stream.empty();
    }
  }
}
