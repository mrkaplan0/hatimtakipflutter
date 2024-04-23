import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/googleAds/banner.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class SettingsPage extends ConsumerWidget {
  SettingsPage({super.key});
  final String signOutbtnText = tr("Cikis Yap");
  String usernameText = tr("Kullanici Adi");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Ayarlar".tr()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                maxRadius: 70,
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                usernameText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(ref.read(userViewModelProvider).user!.username),
              const Spacer(),
              const Text("Hatim Oku",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text("Version: 1.0"),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  btnText: signOutbtnText,
                  onPressed: () async {
                    await ref
                        .watch(userViewModelProvider)
                        .signOut()
                        .then((value) {
                      goToRouterPage(value, context, ref);
                    });
                  }),
              const SizedBox(height: 10),
              MyBannerAdWidget()
            ],
          ),
        ));
  }

  void goToRouterPage(bool value, BuildContext context, WidgetRef ref) {
    if (value == true) {
      try {
        ref.invalidate(userViewModelProvider);
        ref.invalidate(pageControllerProv);
        Navigator.popAndPushNamed(context, "/RouterPage");
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
