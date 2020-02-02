import 'package:flutter/material.dart';

import 'pages/favorite_page.dart';
import 'screens/details_screen.dart';
import 'pages/home_page.dart';
import 'models/routes.dart';
import 'utils/consts.dart';
import 'utils/material_routes.dart';
import 'widgets/route_aware_widget.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) => _routes(settings),
    );
  }

  MaterialPageRoute _routes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialRoute(HomePage(), settings: settings);
      case Routes.favorite:
        return MaterialRoute(FavoritePage(), settings: settings);
      case Routes.details:
        return MaterialRoute(DetailsScreen(), settings: settings);
      default:
        return MaterialRoute(HomePage(), settings: settings);
    }
  }
}
