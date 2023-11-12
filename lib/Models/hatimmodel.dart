import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';

class Hatim {
  String id;
  String hatimName;
  MyUser createdBy;
  bool isIndividual;
  bool isPrivate;
  DateTime? deadline;
  List<MyUser> participantsList;
  List<HatimPartModel> partsOfHatimList;
  DateTime createdTime;

  Hatim({
    required this.id,
    required this.hatimName,
    required this.createdBy,
    required this.isIndividual,
    required this.isPrivate,
    this.deadline,
    required this.participantsList,
    required this.partsOfHatimList,
    required this.createdTime,
  });

  factory Hatim.fromJson(Map<String, dynamic> json) {
    return Hatim(
      id: json['id'],
      hatimName: json['hatimName'],
      createdBy: MyUser.fromMap(json['createdBy']),
      isIndividual: json['isIndividual'],
      isPrivate: json['isPrivate'],
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      participantsList: List<MyUser>.from(
          json['participantsList'].map((x) => MyUser.fromMap(x))),
      partsOfHatimList: List<HatimPartModel>.from(
          json['partsOfHatimList'].map((x) => HatimPartModel.fromJson(x))),
      createdTime: DateTime.parse(json['createdTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hatimName': hatimName,
      'createdBy': createdBy.toMap(),
      'isIndividual': isIndividual,
      'isPrivate': isPrivate,
      'deadline': deadline != null ? deadline!.toIso8601String() : null,
      'participantsList':
          List<dynamic>.from(participantsList.map((x) => x.toMap())),
      'partsOfHatimList':
          List<dynamic>.from(partsOfHatimList.map((x) => x.toJson())),
      'createdTime': createdTime.toIso8601String(),
    };
  }
}
