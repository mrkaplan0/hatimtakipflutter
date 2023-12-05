import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/listpage_hatimcard.dart';
import 'package:hatimtakipflutter/Views/detail_pages/hatim_detailpage.dart';
import 'package:hatimtakipflutter/Views/detail_pages/publichatim_detailpage.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class ReadingPage extends ConsumerWidget {
  String readingPageTitle = "Herkesin Katılabileceği Hatimler";

  ReadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hatimList = ref.watch(onlyPublicHatims);

    return Scaffold(
      appBar: AppBar(
        title: Text(readingPageTitle),
      ),
      body: hatimList.when(
          data: (hatimList) {
            return ListView.builder(
                itemCount: hatimList.length,
                itemBuilder: (context, i) {
                  var hatim = hatimList[i];

                  return GestureDetector(
                    child: ListpageHatimCard(hatim: hatim),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PublicHatimDetailPage(hatim: hatim))),
                  );
                });
          },
          error: error,
          loading: loading),
    );
  }

  Widget? error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  Widget? loading() {
    return const CircularProgressIndicator();
  }
}
