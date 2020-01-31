import 'package:redux/redux.dart';

import 'models/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'middlewares/repositories_middleware.dart';
import 'middlewares/repository_middleware.dart';
import 'middlewares/commits_middleware.dart';

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initial(),
  middleware: [
    repositoriesMiddleware,
    repositoryMiddleware,
    commitsMiddleware,
  ].toList(),
);
