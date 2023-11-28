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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  btnText: signOutbtnText,
                  onPressed: () async {
                    await ref
                        .watch(userViewModelProvider)
                        .signOut()
                        .then((value) {
                      goToRouterPage(value, context);
                    });
                  }),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  void goToRouterPage(bool value, BuildContext context) {
    if (value == true) {
      try {
        Navigator.popAndPushNamed(context, "/RouterPage");
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
