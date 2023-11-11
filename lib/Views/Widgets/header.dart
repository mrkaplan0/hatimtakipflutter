import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: SizedBox(
            height: 250,
            width: 250,
            child: Image(image: AssetImage('assets/images/logo.jpeg'))),
      ),
      Text(
        "Hatim Oku",
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
      ),
      Text(
        "Kuran Okuma Uygulaması",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
    ]);
  }
}
