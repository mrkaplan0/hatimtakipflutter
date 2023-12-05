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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    ref.watch(navigationIndexProvider.notifier).state = index;
    /*   setState(() {
      _selectedIndex = index;
    }); */
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Hatimler"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Bireysel"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle), label: "Katıl"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Dua"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ayarlar"),
          ]),
      body: _pages.elementAt(ref.watch(navigationIndexProvider)),
    );
  }

  final List<Widget> _pages = [
    const ListsPage(),
    IndividualPage(),
    ReadingPage(),
    const PrayAndQuranPage(),
    const SettingsPage()
  ];
}
