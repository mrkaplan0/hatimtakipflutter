import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/0_hatimnamepage.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/1_selectindividualpage.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/2_hatimprivacypage.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/3_selectdatePage.dart';
import 'package:hatimtakipflutter/Views/createNewHatim/4_cuzsettings.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
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
            scrollDirection: Axis.horizontal,
            controller: ref.watch(myPageController.notifier).state,
            onPageChanged: (number) {
              setState(() {
                _currentPageNotifier.value = number;
              });
            },
            children: _list,
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

  final List<Widget> _list = <Widget>[
    HatimnamePage(),
    SelectIndividualPage(),
    HatimPrivacyPage(),
    SelectDatePage(),
    const CuzSettingsPage(),
  ];
}
