import 'package:redux/redux.dart';

import 'middlewares/routes_middleware.dart';
import 'middlewares/commits_middleware.dart';
import 'middlewares/github_middleware.dart';
import 'models/app_state.dart';
import 'reducers/app_state_reducer.dart';

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initial(),
  middleware: [
    routesMiddleware,
    githubMiddleware,
    commitsMiddleware,
  ].toList(),
);
