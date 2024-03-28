import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hatimtakipflutter/Viewmodels/parts_viewmodel.dart';
import 'package:hatimtakipflutter/routerpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  RequestConfiguration(testDeviceIds: ["BB2677239622E29D61B45E018B52B68C"]);
  await EasyLocalization.ensureInitialized();

  runApp(ProviderScope(
    child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('tr'),
          Locale('de'),
          Locale('fr'),
          Locale('ar')
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('tr'),
        // startLocale: PlatformDispatcher.instance.locale,
        child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    PartsOfHatimViewModel.deviceLocale =
        context.deviceLocale.toString().substring(0, 2);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(color: Colors.amber);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routes: {"/RouterPage": (context) => const RouterPage()},
            theme: ThemeData(
              fontFamily: "JosefinSans",
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
              useMaterial3: true,
            ),
            home: const RouterPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: Colors.white,
          child: const SizedBox(
              height: 250,
              width: 250,
              child: Image(image: AssetImage('assets/images/logo.jpeg'))),
        );
      },
    );
  }
}
