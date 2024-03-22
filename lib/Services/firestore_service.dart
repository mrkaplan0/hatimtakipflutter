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
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');

    try {
      await docRefHatimList
          .doc(newHatim.id)
          .set(newHatim.toJson(), SetOptions(merge: true));
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
  Future<bool> updateOwnerOfPart(MyUser newOwner, HatimPartModel part) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      final userMap = newOwner.toJson();
      final pubDocRef = docRefHatimList.doc(part.hatimID);

      db.runTransaction((transaction) async {
        final hatimData = await transaction.get(pubDocRef);
        var newParticipantsList = hatimData.data()!["participantsList"];
        newParticipantsList.add(userMap);

        List partList = hatimData.data()!['partsOfHatimList'];
        for (int i = 0; i < partList.length; i++) {
          if (partList[i]["id"] == part.id) {
            partList[i]["ownerOfPart"] = userMap;
            transaction.update(pubDocRef, {
              "participantsList": newParticipantsList,
              'partsOfHatimList': partList
            });
            break;
          }
        }
      });
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
    return true;
  }

  @override
  Future<bool> updateRemainingPages(HatimPartModel part) async {
    final docRefHatimList =
        db.collection('Hatimler').doc('MainLists').collection('HatimLists');
    try {
      final pubDocRef = docRefHatimList.doc(part.hatimID);

      db.runTransaction((transaction) async {
        final snapshot = await transaction.get(pubDocRef);

        List partList = snapshot.data()!['partsOfHatimList'];
        for (int i = 0; i < partList.length; i++) {
          if (partList[i]["id"] == part.id) {
            partList[i]['remainingPages'] = part.remainingPages;
            transaction.update(pubDocRef, {'partsOfHatimList': partList});
            break;
          }
        }
      }).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"),
      );
    } catch (error) {
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
