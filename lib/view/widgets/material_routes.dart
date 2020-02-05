import 'package:flutter/material.dart';

import '../widgets/route_aware_widget.dart';

class MaterialRoute<T> extends MaterialPageRoute<T> {
  MaterialRoute(Widget widget, {RouteSettings settings})
      : super(
          builder: (_) => RouteAwareWidget(child: widget),
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return FadeTransition(opacity: animation, child: child);
  }
}

class FabMaterialRoute<T> extends MaterialPageRoute<T> {
  FabMaterialRoute(Widget widget, {RouteSettings settings})
      : super(
          builder: (_) => RouteAwareWidget(child: widget),
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }
}
