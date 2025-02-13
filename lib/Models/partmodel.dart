// ignore_for_file: prefer_null_aware_operators

import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:uuid/uuid.dart';

class PartModel {
  String id = const Uuid().v4().toString();
  String hatimID;
  String hatimName;
  List<int> pages;
  MyUser? ownerOfPart;
  List<int> remainingPages;
  DateTime? deadline;
  bool isPrivate;

  PartModel({
    required this.id,
    required this.hatimID,
    required this.hatimName,
    required this.pages,
    this.ownerOfPart,
    required this.remainingPages,
    this.deadline,
    required this.isPrivate,
  });

  PartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        hatimID = json['hatimID'],
        hatimName = json['hatimName'],
        pages = List<int>.from(json['pages']),
        ownerOfPart = json['ownerOfPart'] != null
            ? MyUser.fromJson(json['ownerOfPart'])
            : null,
        remainingPages = List<int>.from(json['remainingPages']),
        deadline =
            json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
        isPrivate = json['isPrivate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hatimID': hatimID,
      'hatimName': hatimName,
      'pages': pages,
      'ownerOfPart': ownerOfPart != null ? ownerOfPart!.toJson() : null,
      'remainingPages': remainingPages,
      'deadline': deadline != null ? deadline!.toIso8601String() : null,
      'isPrivate': isPrivate,
    };
  }
}
