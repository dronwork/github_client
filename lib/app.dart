import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions/db_action.dart';
import 'actions/github_action.dart';
import 'view/widgets/material_routes.dart';
import 'view/widgets/route_aware_widget.dart';
import 'view/view.dart';
import 'models/app_state.dart';
import 'models/routes.dart';
import 'utils/consts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        store.dispatch(
          GitHubOnInitAction(
            isInitData: true,
            pageNumber: 0,
            itemsPerPage: AppState.itemsPerPage,
            isUpdateData: true,
          ),
        );
        store.dispatch(DbOnInitAction());
      },
      converter: (Store<AppState> store) => store,
      builder: (context, viewModel) => MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) => _routes(settings),
      ),
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
