import 'package:flutter/material.dart';

import 'models/routes.dart';
import 'utils/consts.dart';
import 'view/widgets/material_routes.dart';
import 'view/widgets/route_aware_widget.dart';
import 'view/view.dart';

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
        return MaterialRoute(HomeContainer(), settings: settings);
      case Routes.favorite:
        return MaterialRoute(FavoriteContainer(), settings: settings);
      case Routes.details:
        return MaterialRoute(DetailsScreen(), settings: settings);
      default:
        return MaterialRoute(HomeContainer(), settings: settings);
    }
  }
}
