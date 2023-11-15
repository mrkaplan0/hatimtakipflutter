import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: SizedBox(
              height: 170,
              width: 170,
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
      ]),
    );
  }
}
