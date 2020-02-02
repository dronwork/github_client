import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  final Widget body;

  MainScreen({@required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: body,
    );
  }
}
