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
  Stream<List<Hatim>> readHatimList(MyUser user);
  Future<bool> updateOwnerOfPart(MyUser newOwner, HatimPartModel part);
  Future<bool> updateRemainingPages(HatimPartModel part);
  Stream<List<Hatim>> fetchOnlyPublicHatims();
}
