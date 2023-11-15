import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  final String signOutbtnText = "Çıkış yap";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ayarlar"),
        ),
        body: Column(
          children: [
            CustomButton(
                btnText: signOutbtnText,
                onPressed: () {
                  ref.watch(userViewModelProvider).signOut().then((value) {
                    if (value == true) {
                      Navigator.popAndPushNamed(context, "/RouterPage");
                    }
                  });
                })
          ],
        ));
  }
}
