import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/routerpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
 /*

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {"/RouterPage": (context) => const RouterPage()},
              theme: ThemeData(
                fontFamily: "JosefinSans",
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
                useMaterial3: true,
              ),
              home: const RouterPage(),
            );
 */