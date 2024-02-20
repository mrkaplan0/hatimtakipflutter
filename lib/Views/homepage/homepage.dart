import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/individualspage.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/listpage.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/prayandQuranpage.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/readingpage.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/settingspage.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _onItemTapped(int index) {
    ref.watch(navigationIndexProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.cyan,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          currentIndex: ref.watch(navigationIndexProvider),
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.list), label: "Hatimler".tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person), label: "Bireysel".tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.add_circle), label: "Katil".tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book), label: "duam".tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings), label: "Ayarlar".tr()),
          ]),
      body: _pages.elementAt(ref.watch(navigationIndexProvider)),
    );
  }

  final List<Widget> _pages = [
    ListsPage(),
    IndividualPage(),
    ReadingPage(),
    PrayAndQuranPage(),
    SettingsPage()
  ];
}
