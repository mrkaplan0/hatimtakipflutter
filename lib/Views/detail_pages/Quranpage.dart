import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Views/detail_pages/cuzfinishedpage.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
import 'package:pdfx/pdfx.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final previousPageButtonActivate = StateProvider<bool>((ref) => true);

// ignore: must_be_immutable
class QuranPage extends ConsumerStatefulWidget {
  int? initialPage = 0;
  HatimPartModel? part;

  QuranPage({super.key, this.initialPage, this.part});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuranPageState();
}

class _QuranPageState extends ConsumerState<QuranPage> {
  int _actualPageNumber = 2, _allPagesCount = 0;
  late PdfController _pdfController;
  bool isVisible = true;
  String appBartitle = tr("Kuran");

  @override
  void initState() {
    WakelockPlus.enable();
    widget.part != null
        ? _actualPageNumber = widget.part!.remainingPages.first + 2
        : _actualPageNumber;
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/Kuran.pdf'),
      initialPage: _actualPageNumber,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.part != null) {
          //remove last page
          removePageAction();
          //update part`s page
          ref.read(updateRemainingPagesProv(widget.part!));
          ref.invalidate(getMyIndividualParts);
        }
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PdfView(
              controller: _pdfController,
              scrollDirection: Axis.horizontal,
              reverse: true,
              pageSnapping: false,
              physics: const NeverScrollableScrollPhysics(),
              onDocumentLoaded: (document) {
                setState(() {
                  _allPagesCount = document.pagesCount;
                });
              },
              onPageChanged: (page) {
                setState(() {
                  _actualPageNumber = page;
                });
              },
            ),
            backButtonWidget(context),
            prevAndNextButtonWidget()
          ],
        ),
      ),
    );
  }

  Align prevAndNextButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //NEXT PAGE BUTTON
          IconButton(
            icon: const Icon(Icons.arrow_circle_left_rounded, size: 50),
            onPressed: () {
              //go next page
              _pdfController.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );

              if (widget.part != null) {
                //remove last page
                removePageAction();
                //update part`s page
                ref.read(updateRemainingPagesProv(widget.part!));
                //when cuz finished, navigate to..
                if (widget.part!.remainingPages.isEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CuzFinishedPage()));
                }
              }
            },
          ),
          // Page numbers
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              '${_actualPageNumber - 2}/$_allPagesCount',
              style: const TextStyle(fontSize: 22),
            ),
          ),

          // PREVIOUS PAGE BUTTON
          IconButton(
            icon: const Icon(Icons.arrow_circle_right, size: 50),
            onPressed: _actualPageNumber == 2 ||
                    widget.part != null &&
                        widget.part!.remainingPages.isNotEmpty &&
                        widget.part!.remainingPages.first ==
                            widget.part!.pages.first
                ? null
                : () {
                    _pdfController.previousPage(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 100),
                    );
                    if (widget.part != null) {
                      undoAction();
                      //update part`s page

                      ref.read(updateRemainingPagesProv(widget.part!));
                    }
                  },
          ),
        ],
      ),
    );
  }

  void removePageAction() {
    if (widget.part != null) {
      widget.part!.remainingPages.isNotEmpty
          ? widget.part!.remainingPages.removeAt(0)
          : null;
    }
  }

//Back Button
  Align backButtonWidget(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 40.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    //remove last page
                    removePageAction();
                    //update part`s page
                    if (widget.part != null) {
                      ref.read(updateRemainingPagesProv(widget.part!));

                      ref.invalidate(getMyIndividualParts);
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ],
          ),
        ));
  }

  void undoAction() {
    if (widget.part != null) {
      if (widget.part!.remainingPages.isNotEmpty) {
        int firstItem = widget.part!.remainingPages.first;
        widget.part!.remainingPages.insert(0, firstItem - 1);

        if (widget.part!.remainingPages.first == widget.part!.pages.first) {
          ref.read(previousPageButtonActivate.notifier).state = false;
        }
      } else {
        widget.part!.remainingPages.add(widget.part!.pages.last);
        print(widget.part);
        print("undo");
      }
    }
  }
}
