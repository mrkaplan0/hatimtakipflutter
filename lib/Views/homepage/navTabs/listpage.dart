import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/listpage_hatimcard.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/hatim_settings.dart';
import 'package:hatimtakipflutter/Views/detail_pages/hatim_detailpage.dart';
import 'package:hatimtakipflutter/Views/googleAds/banner.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class ListsPage extends ConsumerWidget {
  ListsPage({super.key});
  final String _listpageTitle = tr("Hatimler");
  final String _createNewHatimText = tr("Yeni Hatim Olustur");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hatims = ref.watch(fetchHatims);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_listpageTitle),
          actions: [_createNewHatimButton(context)],
        ),
        body: Stack(
          children: [
            hatims.when(
                data: (hatimList) {
                  //   final listStream = ref.watch(getMyIndividualParts);
                  return ListView.builder(
                      shrinkWrap: true,
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
            Align(alignment: Alignment.bottomCenter, child: MyBannerAdWidget())
          ],
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

  Widget error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }
}
