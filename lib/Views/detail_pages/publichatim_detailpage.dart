import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
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
              return ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, i) {
                  return parts[i].ownerOfPart == null
                      ? Consumer(
                          builder: (context, ref, child) {
                            return SizedBox(
                              height: 70,
                              child: Card(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  partInfo(ref, parts, i),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: TextButton(
                                        onPressed: () async {
                                          await ref
                                              .read(firestoreProvider)
                                              .updateOwnerOfPart(
                                                  ref
                                                      .read(
                                                          userViewModelProvider)
                                                      .user!,
                                                  parts[i]);
                                          ref.invalidate(fetchHatims);
                                          ref.invalidate(myIndividualParts);
                                          ref.invalidate(
                                              navigationIndexProvider);
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        },
                                        child: Text(readButtonText)),
                                  )
                                ],
                              )),
                            );
                          },
                        )
                      : const SizedBox();
                },
              );
            },
            error: error,
            loading: loading));
  }

  Padding partInfo(WidgetRef ref, List<HatimPartModel> parts, int i) {
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
