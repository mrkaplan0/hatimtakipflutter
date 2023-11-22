// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class HatimnamePage extends ConsumerWidget {
  HatimnamePage({super.key});

  final String hatimNametitle = "Hatminize bir isim verin.";
  final String hatimNameexample = "Örnek: Ramazan Hatmi";
  final String nextButtonText = "Sonraki";

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size / 4,
            ),
            Icon(
              Icons.menu_book,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(hatimNametitle),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: hatimNameexample,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                contentPadding: const EdgeInsets.only(left: 8.0),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ref.read(newHatimProvider).hatimName = _controller.text;
                ref.read(newHatimProvider).createdBy =
                    ref.read(userViewModelProvider).user;
                ref.read(myPageController.notifier).state.jumpToPage(1);
              },
              child: Text(nextButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
