import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';

class ListCardMetods {
  static String returnDeadline(DateTime? deadline) {
    if (deadline != null) {
      var formattedDate = DateFormat.yMd().add_Hm().format(deadline);
      return formattedDate;
    } else {
      return "Süre siniri yok.".tr();
    }
  }

  static double countRemainingTime(Hatim hatim) {
    if (hatim.deadline != null) {
      var remainingDay = hatim.deadline!.difference(DateTime.now());
      var allDaysForHatim = hatim.deadline!.difference(hatim.createdTime!);

      var rate =
          remainingDay.inHours.toDouble() / allDaysForHatim.inHours.toDouble();
      if (rate < 0) {
        rate = 0;
      }
      return rate;
    } else {
      return 1.0;
    }
  }

  static int whenWillBeHatimDeleted(Hatim hatim) {
    //After hatim finished, it will be deleted after 5 days.
    if (hatim.deadline != null) {
      var remainingDay = hatim.deadline!.difference(DateTime.now());

      return remainingDay.inDays;
    } else {
      var remainingDay = hatim.createdTime!.difference(DateTime.now());
// for any hatim, max. 3 years from createdTime, then delete hatim.
      return 1090 + remainingDay.inDays;
    }
  }

  static setCPIndicatorColor(double rate) {
    switch (rate) {
      case 0.0:
        return Colors.grey;
      case < 0.25:
        return Colors.red;
      case >= 0.25 && < 0.5:
        return Colors.orange;
      case >= 0.5:
        return Colors.cyan;

      default:
        return Colors.cyan;
    }
  }

  static Widget? error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  static Widget? loading() {
    return const CircularProgressIndicator();
  }
}
