import 'package:hatimtakipflutter/Models/hatimmodel.dart';

import 'package:hatimtakipflutter/Models/partmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';

abstract class MyDatabaseDelegate {
  Future<bool> saveMyUser(MyUser user);
  Future<MyUser?> readMyUser(String userId);
  Future<List<MyUser>> fetchUserList();
  Future<List<MyUser>> fetchfavoritesPeopleList(MyUser user);
  Future<bool> createNewHatim(Hatim newHatim);
  Future<bool> deleteHatim(Hatim hatim);
  Stream<List<Hatim>> readHatimList(MyUser user);
  Stream<List<PartModel>> fetchHatimParts(Hatim hatim);
  Future<List<PartModel>> fetchIndividualParts(
      List<Hatim> hatimList, MyUser myUser);
  Future<bool> updateOwnerOfPart(MyUser newOwner, PartModel part);
  Future<bool> updateRemainingPages(PartModel part);
  Stream<List<Hatim>> fetchOnlyPublicHatims();
  Future<bool> changeHatimPrivacySettings(Hatim hatim, bool isPrivacy);
}
