import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';

abstract class MyDatabaseDelegate {
  Future<bool> saveMyUser(MyUser user);
  Future<MyUser?> readMyUser(String userId);
  Future<List<MyUser>> fetchUserList();
  Future<List<MyUser>> fetchfavoritesPeopleList(MyUser user);
  Future<bool> createNewHatim(Hatim newHatim);
  Future<bool> deleteHatim(Hatim hatim);
  Future<List<Hatim>> readHatimList(MyUser user);
  Future<List<HatimPartModel>> fetchHatimParts(Hatim hatim);
  Future<bool> updateOwnerOfPart(
      MyUser newOwner, HatimPartModel part, Hatim hatim);
  Future<bool> updateRemainingPages(HatimPartModel part);
  Future<List<Hatim>> fetchOnlyPublicHatims();
  Future<List<HatimPartModel>> fetchOnlyFreiPartsOfPublicHatims(Hatim hatim);
}
