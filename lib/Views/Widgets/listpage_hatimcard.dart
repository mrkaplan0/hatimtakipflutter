import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/listpage_cardmetods.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ListpageHatimCard extends ConsumerWidget {
  const ListpageHatimCard({
    super.key,
    required this.hatim,
  });

  final Hatim hatim;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var rate = ListCardMetods.countRemainingTime(hatim);
    var remainingDays = ListCardMetods.whenWillBeHatimDeleted(hatim);
    if (remainingDays == -5) {
      ref.read(firestoreProvider).deleteHatim(hatim);
    }
    return SizedBox(
        height: 70,
        width: double.infinity - 20,
        child: Stack(
          children: [
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 20),
                    child: CircularPercentIndicator(
                      radius: 16.0,
                      lineWidth: 5.0,
                      animation: true,
                      animationDuration: 800,
                      backgroundColor: Colors.grey,
                      progressColor: ListCardMetods.setCPIndicatorColor(rate),
                      //strokeWidth: 7,
                      percent: rate,
                      center: Text(
                        hatim.hatimName != null && hatim.hatimName!.length > 1
                            ? hatim.hatimName!.toUpperCase().substring(0, 1)
                            : "",
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hatim Adi:",
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ).tr(args: ["${hatim.hatimName}"]),
                        const Text("Bitis Tarihi").tr(args: [
                          (ListCardMetods.returnDeadline(hatim.deadline))
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (remainingDays < 0)
              Container(
                color: Colors.white.withOpacity(0.8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Süre bitti. gün sonra silinecek"
                          .tr(args: ["${5 + remainingDays}"]),
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
