import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/hatim_settings.dart';

class ListsPage extends ConsumerWidget {
  const ListsPage({super.key});
  final String _listpageTitle = "Hatimler";
  final String _createNewHatimText = "Yeni Hatim Oluştur";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_listpageTitle),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HatimSettingPage()));
                },
                child: Text(_createNewHatimText))
          ],
        ),
        body: const Center(
          child: Text("Hatimler"),
        ));
  }
}
