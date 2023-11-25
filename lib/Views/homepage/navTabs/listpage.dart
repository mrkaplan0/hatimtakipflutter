import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/listpage_hatimcard.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/hatim_settings.dart';
import 'package:hatimtakipflutter/Views/detail_pages/hatim_detailpage.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class ListsPage extends ConsumerWidget {
  const ListsPage({super.key});
  final String _listpageTitle = "Hatimler";
  final String _createNewHatimText = "Yeni Hatim Oluştur";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hatims = ref.watch(fetchHatims);
    return Scaffold(
        appBar: AppBar(
          title: Text(_listpageTitle),
          actions: [_createNewHatimButton(context)],
        ),
        body: Center(
          child: hatims.when(
              data: (hatimList) {
                return ListView.builder(
                    itemCount: hatimList.length,
                    itemBuilder: (context, i) {
                      var hatim = hatimList[i];

                      return GestureDetector(
                        child: ListpageHatimCard(hatim: hatim),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HatimDetailsPage(hatim: hatim))),
                      );
                    });
              },
              error: error,
              loading: loading),
        ));
  }

  TextButton _createNewHatimButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HatimSettingPage()));
        },
        child: Text(_createNewHatimText));
  }

  Widget? error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  Widget? loading() {
    return const CircularProgressIndicator();
  }
}
