import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/partmodel.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/5_add_usertohatim.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

final editfuncActivatePro = StateProvider.autoDispose<bool>((ref) => false);

// ignore: must_be_immutable
class HatimDetailsPage extends ConsumerWidget {
  Hatim hatim;
  String editBtnText = tr("Kisileri Düzenle");

  String deleteBtnText = tr("Hatmi Sil");

  String editInfoSnackbarText = tr("Düzenlemek istediginiz cüzü secin.");

  String cancelText = tr("Iptal");

  String warningTitle = tr("Uyari");

  String warningInfo = tr("Hatmi silmek istediginizden emin misiniz?");

  String changePrivacyText = tr("Gizlilik Ayarlari");
  HatimDetailsPage({super.key, required this.hatim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partList = ref.watch(fetchHatimParts(hatim));

    return Scaffold(
        appBar: AppBar(
          title: Text(hatim.hatimName ?? ''),
          actions: ref.read(userViewModelProvider).user!.id ==
                  hatim.createdBy!.id
              ? [
                  if (ref.watch(editfuncActivatePro) == true)
                    IconButton(
                        onPressed: () {
                          ref.watch(editfuncActivatePro.notifier).state = false;
                        },
                        icon: Text(
                          cancelText,
                          style: TextStyle(color: Colors.cyan.shade700),
                        )),
                  _popUpMenu(context, ref),
                ]
              : null,
        ),
        body: partList.when(
            data: (parts) {
              parts.sort((a, b) => a.pages.first.compareTo(b.pages.first));
              return ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, i) {
                  return Consumer(
                    builder: (context, ref, child) {
                      return GestureDetector(
                        onTap: () => ref.watch(editfuncActivatePro) == true
                            ? _editFunc(context, ref, i)
                            : null,
                        child: SizedBox(
                          height: 80,
                          child: Card(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ref
                                        .read(hatimPartsProvider.notifier)
                                        .setPartName(parts[i].pages)),
                                    Text(
                                      "Okuyan:".tr(args: [
                                        (parts[i].ownerOfPart != null
                                            ? parts[i].ownerOfPart!.username
                                            : "")
                                      ]),
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                    rateLine(context, parts[i])
                                  ],
                                ),
                              ),
                              // when edit mode activated, show an arrow in card
                              ref.watch(editfuncActivatePro) == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 18,
                                        color: Colors.cyan.shade700
                                            .withOpacity(0.5),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )),
                        ),
                      );
                    },
                  );
                },
              );
            },
            error: error,
            loading: loading));
  }

  Widget? error(Object error, StackTrace stackTrace) {
    return null;
  }

  Widget? loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget rateLine(BuildContext context, PartModel part) {
    var width = MediaQuery.of(context).size.width - 100;

    return Row(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: width,
              height: 2,
              color: Colors.grey,
            ),
            Container(
              width: width *
                  _countRate(part.remainingPages.length, part.pages.length),
              height: 4,
              color: Colors.cyan.shade700,
            ),
          ],
        ),
        Text(
          "  ${part.pages.length - part.remainingPages.length} / ${part.pages.length}",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }

  _popUpMenu(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        // popupmenu item 0: change Privacy
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.lock_open,
                color: Colors.cyan.shade200,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(changePrivacyText)
            ],
          ),
          onTap: () {
            _showPrivacyChangeDialog(context, ref);
          },
        ),
        // popupmenu item 1: edit users
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: Colors.cyan.shade200,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(editBtnText)
            ],
          ),
          onTap: () {
            //activate  card onTap for editing
            ref.read(editfuncActivatePro.notifier).state = true;
            // show info 'how to edit'
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(editInfoSnackbarText),
              duration: const Duration(seconds: 4),
            ));
          },
        ),
        // popupmenu item 2: delete hatim
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_outlined,
                color: Colors.cyan.shade200,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(deleteBtnText)
            ],
          ),
          onTap: () {
            _showDeleteDialog(context, ref);
          },
        ),
      ],
      offset: const Offset(0, 100),
      color: Colors.cyan.shade700,
      elevation: 2,
    );
  }

  _editFunc(BuildContext context, WidgetRef ref, int i) {
    ref.invalidate(editfuncActivatePro);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddUserToHatimPage(
              selectedPartIndex: i,
              fromPage: FromPage.hatimDetails,
              part: hatim.partsOfHatimList[i],
            )));
  }

  _showDeleteDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      warningTitle,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      warningInfo,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CustomButton(
                              btnText: deleteBtnText,
                              textColor: Colors.white,
                              buttonBgColor: Colors.red,
                              onPressed: () async {
                                await ref
                                    .read(firestoreProvider)
                                    .deleteHatim(hatim);
                                ref.invalidate(fetchHatims);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .popAndPushNamed("/RouterPage");
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: CustomButton(
                              btnText: cancelText,
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _countRate(int remaining, int all) {
    var difference = all - remaining;

    double rate = difference.toDouble() / all.toDouble();

    return rate;
  }

  _showPrivacyChangeDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hatime kimler erisebilsin?".tr()),
          content: SizedBox(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gecerli Gizlilik Ayariniz: ".tr()),
                hatim.isPrivate
                    ? Text(
                        "Sadece Sectigim Kisiler".tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    : Text(
                        "Herkes".tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  hatim.isPrivate = !hatim.isPrivate;
                  ref.read(changePrivacy(hatim));

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Icon(Icons.check_box, color: Colors.green)));
                },
                child: Text(hatim.isPrivate
                    ? "Herkes".tr()
                    : "Sadece Sectigim Kisiler".tr())),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Iptal".tr()))
          ],
        );
      },
    );
  }
}
