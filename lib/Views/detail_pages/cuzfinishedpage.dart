import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';

final isVisible = StateProvider.autoDispose<bool>((ref) => true);

class CuzFinishedPage extends ConsumerWidget {
  const CuzFinishedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 2), () {
      ref.watch(isVisible.notifier).state = false;
    });

    return Scaffold(
      body: Consumer(builder: (context, ref, w) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/havaifisek.jpg")),
                ),
                AnimatedOpacity(
                  opacity: ref.watch(isVisible) ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    "Tebrikler".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[Shadow(blurRadius: 15)]),
                  ),
                ),
                AnimatedOpacity(
                  opacity: ref.watch(isVisible) ? 0.0 : 1.0,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    "Cüzünüzü tamamladiniz.".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[Shadow(blurRadius: 15)]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  btnText: "Kapat".tr(),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/");
                  }),
            )
          ],
        );
      }),
    );
  }
}
