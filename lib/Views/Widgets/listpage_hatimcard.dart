import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/listpage_cardmetods.dart';

class ListpageHatimCard extends StatelessWidget {
  const ListpageHatimCard({
    super.key,
    required this.hatim,
  });

  final Hatim hatim;

  @override
  Widget build(BuildContext context) {
    var rate = ListCardMetods.countRemainingTime(hatim);
    return SizedBox(
        height: 70,
        width: double.infinity - 20,
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.grey,
                      valueColor: ListCardMetods.setCPIndicatorColor(rate),
                      strokeWidth: 7,
                      value: rate,
                    ),
                    Text(
                      hatim.hatimName != null && hatim.hatimName!.length > 1
                          ? hatim.hatimName!.toUpperCase().substring(0, 1)
                          : "",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
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
        ));
  }
}
