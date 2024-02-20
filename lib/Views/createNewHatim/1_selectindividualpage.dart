// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class SelectIndividualPage extends ConsumerWidget {
  SelectIndividualPage({super.key});

  bool isIndividual = false;
  final String nextButtonText = tr("Sonraki");
  final String individualInfoText = tr("Nasil bir hatim arzu ediyorsun?");
  final String indiviButtonText = tr("Bireysel");
  final String multiButtonText = tr("Cok katilimcili");

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
                  Icons.person,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.compare_arrows,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.people,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(individualInfoText),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        btnText: indiviButtonText,
                        onPressed: () {
                          ref.read(newHatimProvider).isIndividual = true;
                          //if a hatim is individual, it's also private.
                          ref.read(newHatimProvider).isPrivate = true;
                          ref
                              .read(hatimPartsProvider.notifier)
                              .setIndividualHatim(ref.read(newHatimProvider));
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
                        btnText: multiButtonText,
                        onPressed: () {
                          ref.read(newHatimProvider).isIndividual = false;
                          ref
                              .read(myPageController.notifier)
                              .state
                              .jumpToPage(2);
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
