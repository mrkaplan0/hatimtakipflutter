import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/listpage_hatimcard.dart';
import 'package:hatimtakipflutter/Views/detail_pages/publichatim_detailpage.dart';
import 'package:hatimtakipflutter/Views/googleAds/banner.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class PublicReadingPage extends ConsumerWidget {
  String readingPageTitle = tr("Herkesin Katilabilecegi Hatimler");

  PublicReadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hatimList = ref.watch(onlyPublicHatims);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          readingPageTitle,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          hatimList.when(
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
                                    PublicHatimDetailPage(hatim: hatim))),
                      );
                    });
              },
              error: error,
              loading: loading),
          Align(alignment: Alignment.bottomCenter, child: MyBannerAdWidget())
        ],
      ),
    );
  }

  Widget error(Object error, StackTrace stackTrace) {
    return const Text('error');
  }

  Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }
}
