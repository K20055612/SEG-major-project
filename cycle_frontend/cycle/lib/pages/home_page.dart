import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/menu.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<MainPageState> _myMainPageState = GlobalKey<MainPageState>();

  void myHomePageMapRefresh() {
    _myMainPageState.currentState?.myMapRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(
          'Map',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SlidingUpPanel(
        color: Colors.lightBlue,
        minHeight: 185,
        maxHeight: 450,
        parallaxEnabled: true,
        parallaxOffset: 1.0,
        isDraggable: true,
        backdropTapClosesPanel: true,
        body: MainPage(key: _myMainPageState),
        panelBuilder: (controller) => SlideUpWidget(
          controller: controller,
          mapRefreshCallback: myHomePageMapRefresh,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
    );
  }
}