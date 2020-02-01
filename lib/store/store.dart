import 'package:redux/redux.dart';

import 'models/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'middlewares/github_middleware.dart';

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initial(),
  middleware: [
    githubMiddleware,
  ].toList(),
);
