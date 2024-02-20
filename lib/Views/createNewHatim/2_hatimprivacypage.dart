// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class HatimPrivacyPage extends ConsumerWidget {
  HatimPrivacyPage({super.key});

  bool isIndividual = false;
  final String nextButtonText = tr("Sonraki");
  final String makePrivatInfoText = tr("Hatime kimler erisebilsin?");
  final String onlyChosenPersonButtonText = tr("Sadece Sectigim Kisiler");
  final String publicAccessButtonText = tr("Herkes");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size / 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.compare_arrows,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.lock_open,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(makePrivatInfoText),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: CustomButton(
                        btnText: onlyChosenPersonButtonText,
                        onPressed: () {
                          ref.read(newHatimProvider).isPrivate = true;
                          ref
                              .read(myPageController.notifier)
                              .state
                              .jumpToPage(3);
                        })),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: CustomButton(
                        btnText: publicAccessButtonText,
                        onPressed: () {
                          ref.read(newHatimProvider).isPrivate = false;
                          ref
                              .read(myPageController.notifier)
                              .state
                              .jumpToPage(3);
                        })),
              ],
            ),
            SizedBox(height: size / 3),
          ],
        ),
      ),
    );
  }
}
