import 'package:redux/redux.dart';

import 'middlewares/db_middleware.dart';
import 'middlewares/navigators_middleware.dart';
import 'middlewares/commits_middleware.dart';
import 'middlewares/github_middleware.dart';
import 'reducers/app_state_reducer.dart';
import 'models/app_state.dart';

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initial(),
  middleware: [
    navigatorsMiddleware,
    githubMiddleware,
    commitsMiddleware,
    dbMiddleware,
  ].toList(),
);
