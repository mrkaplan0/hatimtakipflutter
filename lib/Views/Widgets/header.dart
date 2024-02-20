import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
          child: SizedBox(
              height: 170,
              width: 170,
              child: Image(image: AssetImage('assets/images/logo.jpeg'))),
        ),
        const Text(
          "Hatim Oku",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
        ),
        Text(
          "Kuran Okuma Uygulamasi".tr(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ]),
    );
  }
}
