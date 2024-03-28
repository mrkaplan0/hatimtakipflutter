import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:hatimtakipflutter/Views/detail_pages/Quranpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/partmodel.dart';
import 'package:hatimtakipflutter/Viewmodels/listpage_cardmetods.dart';
import 'package:hatimtakipflutter/Views/detail_pages/cuzfinishedpage.dart';
import 'package:hatimtakipflutter/Views/googleAds/banner.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class IndividualPage extends ConsumerStatefulWidget {
  const IndividualPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndividualPageState();
}

class _IndividualPageState extends ConsumerState<IndividualPage> {
  String noResponsibilityText =
      tr("Sorumlu olduğunuz cüz yok.\n Başka hatimlere katilmak icin tikla.");
  String seeOtherHatimsText = tr("Hatimleri Gör");
  String indiviPageTitle = tr("Sorumlu Olduğun Cüzler");
  String remainingPageText = tr("Kalan Sayfalar");
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(myIndividualParts);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          indiviPageTitle,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Consumer(builder: (context, reff, w) {
        return list.isNotEmpty
            ? Stack(
                children: [
                  listWidget(context, list, reff),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: MyBannerAdWidget())
                ],
              )
            : Stack(
                children: [
                  listNullWidget(ref),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: MyBannerAdWidget())
                ],
              );
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
      BuildContext context, List<PartModel> list, WidgetRef reff) {
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
              list.sort((a, b) => a.pages.first.compareTo(b.pages.first));
              final showUndoButton = reff.watch(butnActvateListProv(i));
              // if man finished to read part, there is no necessary to see this part`s card

              return list[i].remainingPages.isNotEmpty
                  ? SizedBox(
                      height: 120,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              partsInfoWidget(reff, list, i),
                              Column(
                                children: [
                                  showUndoButton == true
                                      ? IconButton(
                                          onPressed: () {
                                            undoButtonAction(
                                                list, i, reff, context);
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
                              reducingButton(reff, list, i),
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

  Widget reducingButton(WidgetRef ref, List<PartModel> list, int i) {
    return Consumer(
      builder: (kcontext, reff, child) => Expanded(
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
                    reducingButtonAction(list, i, reff, kcontext);
                  },
                  child: Center(
                    child: Text("${list[i].remainingPages.length}"),
                  )),
            ),
          ),
        ],
      )),
    );
  }

  Expanded partsInfoWidget(WidgetRef ref, List<PartModel> list, int i) {
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
  void _updatePart(PartModel part, WidgetRef reff, BuildContext kcontext) {
    int waitingSec = 2;
    if (part.remainingPages.isEmpty) {
      waitingSec = 0;
    }
    _timer?.cancel(); // cancel timer
    _timer = Timer(Duration(seconds: waitingSec), () {
      ref.read(updateRemainingPagesProv(part));
      ref.invalidate(updateRemainingPagesProv);
      ref.invalidate(getMyIndividualParts);
      ref.invalidate(myIndividualParts);
      if (part.remainingPages.isEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (kcontext) => const CuzFinishedPage(),
            fullscreenDialog: true));
      }
    });
  }

  void reducingButtonAction(
      List<PartModel> list, int i, WidgetRef reff, BuildContext kcontext) {
    if (list[i].remainingPages.isNotEmpty) {
      ref.watch(myIndividualParts.notifier).state[i].remainingPages.removeAt(0);

      ref.read(butnActvateListProv(i).notifier).makeTrue();
      _updatePart(list[i], ref, context);
      ref.invalidate(myIndividualParts);
    }
  }

  void undoButtonAction(
      List<PartModel> list, int i, WidgetRef ref, BuildContext context) {
    if (list[i].remainingPages.isNotEmpty) {
      int firstItem = list[i].remainingPages.first;
      list[i].remainingPages.insert(0, firstItem - 1);

      if (list[i].remainingPages.first == list[i].pages.first) {
        ref.read(butnActvateListProv(i).notifier).makeFalse();
      }
    } else {
      list[i].remainingPages.add(list[i].pages.last);
    }

    ref.invalidate(myIndividualParts);
    _updatePart(list[i], ref, context);
  }
}
