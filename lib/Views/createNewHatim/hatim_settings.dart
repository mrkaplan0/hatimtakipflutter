import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/individualspage.dart';
import 'package:hatimtakipflutter/Views/homepage/navTabs/settingspage.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HatimSettingPage extends ConsumerStatefulWidget {
  const HatimSettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HatimSettingPageState();
}

class _HatimSettingPageState extends ConsumerState<HatimSettingPage> {
  late PageController _pageController;
  final _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPageNum = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            allowImplicitScrolling: true,
            children: _list,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (num) {
              setState(() {
                _currentPageNum = num;
                _currentPageNotifier.value = num;
              });
            },
          ),
          _buildCircleIndicator()
        ],
      ),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: _list.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  final List<Widget> _list = <Widget>[SettingsPage(), IndividualPage()];
}
