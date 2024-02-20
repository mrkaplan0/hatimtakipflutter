// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/5_add_usertohatim.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final sliderValueProvider = StateProvider<double>((ref) => 0.0);

// ignore: must_be_immutable
class CuzSettingsPage extends ConsumerWidget {
  CuzSettingsPage({super.key});
  String appBarTitle = tr('Cüz Ayarlari');
  String splitBtnText = tr("Bol");
  String closeBtnText = tr("Kapat");
  String createHatimtext = tr("Hatmi Olustur");
  String waitingText = tr("Lutfen bekleyin...");
  String changePrivacyButtonText = tr("Herkes Erisebilir");
  String warningText = tr("Uyari");
  String controlDialogInfo = tr(
      "Bütün cüzlere kisi atayin ya da hatminizi 'Herkes' erisebilir hale getirin.");
  String nonAddedPersonInfotext = tr("Kisi atanmayan cüz sayisi:");
  String addPersonText = tr("Kisi ata");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(hatimPartsProvider).allParts;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(appBarTitle),
          actions: [
            //save Hatim
            TextButton(
                onPressed: () => _controlHatim(context, ref),
                child: Text(createHatimtext))
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) => Stack(
            children: [
              ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            _showCuzSplitDialog(context, ref, i);
                          },
                          label: splitBtnText,
                          backgroundColor: Theme.of(context).primaryColorLight,
                        )
                      ]),
                      child: Card(
                        shape: Border.all(style: BorderStyle.none),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text((i + 1).toString()),
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                ref
                                    .read(hatimPartsProvider)
                                    .setPartName(list[i].pages),
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUserToHatimPage(
                                                    selectedPartIndex: i,
                                                    fromPage:
                                                        FromPage.cuzSettings,
                                                  )));
                                    },
                                    child: Text(
                                      list[i].ownerOfPart != null
                                          ? list[i].ownerOfPart!.username
                                          : addPersonText,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              if (ref.watch(userViewModelProvider).state == ViewState.busy) ...[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(waitingText),
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
        ));
  }

  _showCuzSplitDialog(BuildContext context, WidgetRef ref, int index) {
    var selectedCuz = ref.watch(hatimPartsProvider).allParts[index];

    return showDialog(
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              final sliderValue = ref.watch(sliderValueProvider);

              return Dialog(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Cüzü sayfadan böl.')
                            .tr(args: ["${sliderValue.toInt()}."]),
                        Slider(
                          value: sliderValue,
                          onChanged: (value) {
                            // Update the slider value when it's changed
                            ref.read(sliderValueProvider.notifier).state =
                                value;
                          },
                          min: 0.0,
                          max: selectedCuz.pages.length.toDouble(),
                          label: sliderValue.toStringAsFixed(1),
                        ),
                        Row(
                          children: [
                            Expanded(
                              //  the split confirm button.
                              child: CustomButton(
                                  btnText: splitBtnText,
                                  onPressed: () {
                                    if (sliderValue.toInt() != 0 &&
                                        sliderValue.toInt() !=
                                            selectedCuz.pages.length) {
                                      ref
                                          .read(hatimPartsProvider.notifier)
                                          .splitPart(
                                              index, sliderValue.toInt());

                                      ref.invalidate(sliderValueProvider);
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            //close button
                            Expanded(
                              child: CustomButton(
                                  btnText: closeBtnText,
                                  onPressed: () {
                                    ref.invalidate(sliderValueProvider);
                                    Navigator.pop(context);
                                  }),
                            )
                          ],
                        ),
                      ],
                    )),
              );
            },
          );
        });
  }

  void _controlHatim(BuildContext context, WidgetRef ref) {
    final newHatim = ref.read(newHatimProvider);

    if (newHatim.isPrivate == true) {
      // if hatim is private, it means that only users i chosed can join to hatim. therefore we must make a control.
      var nonAddedPersonToCuzList =
          ref.read(hatimPartsProvider).controlNonAddedPersonToCuz();
      if (nonAddedPersonToCuzList.isEmpty) {
        _saveHatim(context, ref, newHatim);
      } else {
        _showDialogForControlResult(
            context, ref, nonAddedPersonToCuzList.length);
      }
    } else {
      _saveHatim(context, ref, newHatim);
    }
  }

  void _saveHatim(BuildContext context, WidgetRef ref, Hatim newHatim) async {
    try {
      ref.watch(userViewModelProvider.notifier).state = ViewState.busy;

      newHatim.partsOfHatimList = ref.read(hatimPartsProvider).allParts;
      ref.read(hatimPartsProvider).updateAllParts(newHatim);
      newHatim.participantsList =
          ref.read(hatimPartsProvider).createParticipantList();
      newHatim.createdTime = DateTime.now();

      bool result = await ref.read(firestoreProvider).createNewHatim(newHatim);

      if (result) {
        ref.invalidate(newHatimProvider);
        ref.invalidate(hatimPartsProvider);
        ref.invalidate(fetchHatims);
        ref.invalidate(myIndividualParts);
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/RouterPage');
      }

      ref.watch(userViewModelProvider.notifier).state = ViewState.idle;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      ref.watch(userViewModelProvider.notifier).state = ViewState.idle;
    }
  }

  _showDialogForControlResult(
      BuildContext context, WidgetRef ref, int nonAddedPersonToCuzCount) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        warningText,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        nonAddedPersonInfotext + "$nonAddedPersonToCuzCount",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        controlDialogInfo,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomButton(
                        btnText: changePrivacyButtonText,
                        onPressed: () {
                          ref.read(newHatimProvider).isPrivate = false;
                          Navigator.pop(context);
                        }),
                    CustomButton(
                        btnText: closeBtnText,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
