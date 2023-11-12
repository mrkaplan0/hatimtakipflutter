import 'package:hatimtakipflutter/Models/myuser.dart';

class HatimPartModel {
  String id;
  String hatimID;
  String hatimName;
  List<int> pages;
  MyUser? ownerOfPart;
  List<int> remainingPages;
  DateTime? deadline;
  bool isPrivate;

  HatimPartModel({
    required this.id,
    required this.hatimID,
    required this.hatimName,
    required this.pages,
    this.ownerOfPart,
    required this.remainingPages,
    this.deadline,
    required this.isPrivate,
  });

  factory HatimPartModel.fromJson(Map<String, dynamic> json) {
    return HatimPartModel(
      id: json['id'],
      hatimID: json['hatimID'],
      hatimName: json['hatimName'],
      pages: List<int>.from(json['pages']),
      ownerOfPart: json['ownerOfPart'] != null
          ? MyUser.fromMap(json['ownerOfPart'])
          : null,
      remainingPages: List<int>.from(json['remainingPages']),
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      isPrivate: json['isPrivate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hatimID': hatimID,
      'hatimName': hatimName,
      'pages': pages,
      'ownerOfPart': ownerOfPart != null ? ownerOfPart!.toMap() : null,
      'remainingPages': remainingPages,
      'deadline': deadline != null ? deadline!.toIso8601String() : null,
      'isPrivate': isPrivate,
    };
  }
}
