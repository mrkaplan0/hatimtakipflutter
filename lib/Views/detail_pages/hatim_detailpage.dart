import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class HatimDetailsPage extends ConsumerWidget {
  Hatim hatim;
  HatimDetailsPage({super.key, required this.hatim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partList = ref.watch(fetchHatimParts(hatim));

    return Scaffold(
        appBar: AppBar(title: Text(hatim.hatimName ?? '')),
        body: partList.when(
            data: (parts) {
              parts.sort((a, b) => a.pages.first.compareTo(b.pages.first));
              return ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                      height: 70,
                      width: double.infinity - 20,
                      child: Card(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ref
                                    .read(hatimPartsProvider.notifier)
                                    .setPartName(parts[i].pages)),
                                Text(
                                    "Okuyan: ${parts[i].ownerOfPart?.username}"),
                              ],
                            ),
                          ],
                        ),
                      ));
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
    return const CircularProgressIndicator();
  }
}
