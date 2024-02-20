// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/detail_pages/Quranpage.dart';
import 'package:hatimtakipflutter/Views/detail_pages/digital_rosary.dart';

class PrayAndQuranPage extends ConsumerWidget {
  final String prayPageTitle = tr("Dua ve Kuran");
  final String readQuranBtnText = tr("Kuran Oku");
  final String prayOfHatimText = tr("Hatim Duasi");
  final String digitalRosary = tr("Sanal Tesbih");

  PrayAndQuranPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(prayPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomButton(
                  btnText: readQuranBtnText,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuranPage(initialPage: 0)));
                  }),
              CustomButton(btnText: prayOfHatimText, onPressed: () {}),
              CustomButton(
                  btnText: digitalRosary,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DigitalRosary()));
                  }),
            ],
          ),
        ));
  }
}
