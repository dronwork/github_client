import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/error_notifier_widget.dart';

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
