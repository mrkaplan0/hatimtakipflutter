import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:hatimtakipflutter/Views/detail_pages/Quranpage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/listpage_cardmetods.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class IndividualPage extends ConsumerWidget {
  IndividualPage({super.key});

  String noResponsibilityText =
      tr("Sorumlu olduğunuz cüz yok.\n Başka hatimlere katilmak icin tikla.");
  String seeOtherHatimsText = tr("Hatimleri Gör");
  String indiviPageTitle = tr("Sorumlu Olduğun Cüzler");
  String remainingPageText = tr("Kalan Sayfalar");
  Timer? _timer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          indiviPageTitle,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Consumer(builder: (context, ref, widget) {
        final list = ref.watch(myIndividualParts);
        if (list.isNotEmpty) {
          return listWidget(context, list, ref);
        } else {
          return listNullWidget(ref);
        }
      }),
    );
  }

// if there is no element in list, navigate to user "Hatims Everone can join" => ReadingPage
  Column listNullWidget(WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          noResponsibilityText,
          textAlign: TextAlign.center,
        ),
        TextButton(
            onPressed: () {
              ref.watch(navigationIndexProvider.notifier).state = 2;
            },
            child: Text(seeOtherHatimsText))
      ],
    );
  }

//in list, we have a card. In Card you can reduce remainingPages and make undo.
  Column listWidget(
      BuildContext context, List<HatimPartModel> list, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width / 7),
          child: Text(remainingPageText),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: list.length,
            itemBuilder: (context, i) {
              final showUndoButton = ref.watch(butnActvateListProv(i));
              // if man finished to read part, there is no necessary to see this part`s card
              return list[i].remainingPages.isNotEmpty
                  ? SizedBox(
                      height: 120,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              partsInfoWidget(ref, list, i),
                              Column(
                                children: [
                                  showUndoButton == true
                                      ? IconButton(
                                          onPressed: () {
                                            undoButtonAction(
                                                list, i, ref, context);
                                          },
                                          icon: const Icon(
                                              Icons.settings_backup_restore))
                                      : const SizedBox(
                                          height: 40,
                                        ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => QuranPage(
                                                      part: list[i],
                                                    )));
                                      },
                                      icon: const Icon(Icons.menu_book_sharp)),
                                ],
                              ),
                              reducingButton(ref, list, i),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget reducingButton(WidgetRef ref, List<HatimPartModel> list, int i) {
    return Consumer(
      builder: (context, ref, child) => Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan.shade100.withOpacity(0.4),
                  border: const Border(
                      right: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12)),
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      blurRadius: 1,
                      color: Colors.black12,
                    ),
                  ]),
              child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    reducingButtonAction(list, i, ref, context);
                  },
                  child: Center(
                    child: Text(
                        "${ref.watch(myIndividualParts)[i].remainingPages.length}"),
                  )),
            ),
          ),
        ],
      )),
    );
  }

  Expanded partsInfoWidget(WidgetRef ref, List<HatimPartModel> list, int i) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ref.read(hatimPartsProvider.notifier).setPartName(list[i].pages),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            list[i].hatimName,
            style: const TextStyle(color: Colors.black54),
          ),
          Text(
            ListCardMetods.returnDeadline(list[i].deadline),
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

//this method update the database. we have a timer for the reducing writing counts to database.
  void _updatePart(HatimPartModel part, WidgetRef ref, BuildContext context) {
    _timer?.cancel(); // cancel timer
    _timer = Timer(const Duration(seconds: 2), () {
      try {
        ref.read(updateRemainingPagesProv(part));
        ref.invalidate(updateRemainingPagesProv);
        ref.invalidate(getMyIndividualParts);
        ref.invalidate(myIndividualParts);
      } catch (e) {
        showDialog(
            context: context,
            builder: (dialogContext) {
              return const Dialog(
                child: AlertDialog(
                  title: Text("Error"),
                  content: Text('Data couldn`t be updated.'),
                ),
              );
            });
      }
    });
  }

  void reducingButtonAction(
      List<HatimPartModel> list, int i, WidgetRef ref, BuildContext context) {
    if (list[i].remainingPages.isNotEmpty) {
      ref.watch(myIndividualParts.notifier).state[i].remainingPages.removeAt(0);
      ref.read(butnActvateListProv(i).notifier).makeTrue();
      print(list[i].remainingPages);
      ref.invalidate(myIndividualParts);
      _updatePart(list[i], ref, context);
    } else {
      // Show Ad
    }
  }

  void undoButtonAction(
      List<HatimPartModel> list, int i, WidgetRef ref, BuildContext context) {
    if (list[i].remainingPages.isNotEmpty) {
      int firstItem = list[i].remainingPages.first;
      ref
          .watch(myIndividualParts.notifier)
          .state[i]
          .remainingPages
          .insert(0, firstItem - 1);

      if (list[i].remainingPages.first == list[i].pages.first) {
        ref.read(butnActvateListProv(i).notifier).makeFalse();
      }
    } else {
      ref
          .watch(myIndividualParts.notifier)
          .state[i]
          .remainingPages
          .add(list[i].pages.last);
    }

    ref.invalidate(myIndividualParts);
    _updatePart(list[i], ref, context);
  }
}
