import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:intl/intl.dart';

class ListCardMetods {
  static String returnDeadline(DateTime? deadline) {
    if (deadline != null) {
      var formattedDate = DateFormat.yMd().add_Hm().format(deadline);
      return formattedDate;
    } else {
      return "Süre sınırı yok.";
    }
  }

  static double countRemainingTime(Hatim hatim) {
    if (hatim.deadline != null) {
      var remainingDay = hatim.deadline!.difference(DateTime.now());
      var allDaysForHatim = hatim.deadline!.difference(hatim.createdTime!);

      var rate =
          remainingDay.inHours.toDouble() / allDaysForHatim.inHours.toDouble();

      return rate;
    } else {
      return 1.0;
    }
  }

  static setCPIndicatorColor(double rate) {
    switch (rate) {
      case 0.0:
        return const AlwaysStoppedAnimation<Color>(Colors.grey);
      case < 0.25:
        return const AlwaysStoppedAnimation<Color>(Colors.red);
      case >= 0.25 && < 0.5:
        return const AlwaysStoppedAnimation<Color>(Colors.orange);
      case >= 0.5:
        return const AlwaysStoppedAnimation<Color>(Colors.cyan);

      default:
        return const AlwaysStoppedAnimation<Color>(Colors.cyan);
    }
  }

  static Widget? error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  static Widget? loading() {
    return const CircularProgressIndicator();
  }
}
