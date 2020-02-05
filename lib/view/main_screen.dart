import 'package:flutter/material.dart';

import '../view/widgets/bottom_nav_bar.dart';
import '../view/widgets/error_notifier_widget.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  MainScreen({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: ErrorNotifierWidget(
        child: child,
      ),
    );
  }
}
