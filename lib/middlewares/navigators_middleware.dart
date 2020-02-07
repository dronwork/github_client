import 'package:redux/redux.dart';

import '../actions/routes_action.dart';
import '../models/app_state.dart';
import '../utils/consts.dart';

void navigatorsMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is NavigateReplaceAction) {
    final String routeName = action.routeName;
    final Object arguments = action?.arguments;

    if (store.state.route.last != routeName) {
      navigatorKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);
    }
  }

  if (action is NavigatePushAction) {
    final String routeName = action.routeName;
    final Object arguments = action?.arguments;

    if (store.state.route.last != routeName) {
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
    }
  }

  next(action);
}
