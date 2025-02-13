import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/partmodel.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class PublicHatimDetailPage extends ConsumerWidget {
  Hatim hatim;

  String readButtonText = tr("Oku");
  PublicHatimDetailPage({super.key, required this.hatim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partList = ref.watch(fetchHatimParts(hatim));

    return Scaffold(
        appBar: AppBar(
          title: Text(hatim.hatimName ?? ''),
        ),
        body: partList.when(
            data: (parts) {
              parts.sort((a, b) => a.pages.first.compareTo(b.pages.first));
              List<PartModel> filteredList = [];
              for (var part in parts) {
                if (part.ownerOfPart == null) {
                  filteredList.add(part);
                }
              }
              return filteredList.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (kcontext, i) {
                        return Consumer(
                          builder: (kcontext, ref, child) {
                            return SizedBox(
                              height: 70,
                              child: Card(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  partInfo(ref, filteredList, i),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: TextButton(
                                        onPressed: () async {
                                          await updateOwnerOfPart(
                                              ref, filteredList, i, context);
                                        },
                                        child: Text(readButtonText)),
                                  )
                                ],
                              )),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Uppss!".tr(),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text("Sanirim burada cüz kalmadi.".tr()),
                        ],
                      ),
                    );
            },
            error: error,
            loading: loading));
  }

  Future<void> updateOwnerOfPart(
      WidgetRef ref, List<PartModel> parts, int i, BuildContext context) async {
    var result = await ref
        .read(firestoreProvider)
        .updateOwnerOfPart(ref.read(userViewModelProvider).user!, parts[i]);

    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Padding partInfo(WidgetRef ref, List<PartModel> parts, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        ],
      ),
    );
  }

  Widget? error(Object error, StackTrace stackTrace) {
    return null;
  }

  Widget? loading() {
    return const Center(child: CircularProgressIndicator());
  }
}
