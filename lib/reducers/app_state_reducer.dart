import '../models/app_state.dart';

import 'commits_reducer.dart';
import 'loading_reducer.dart';
import 'github_reducer.dart';
import 'routes_reducer.dart';

AppState appStateReducer(AppState state, action) => AppState(
    isLoading: loadingReducer(state.isLoading, action),
    route: routesReducer(state.route, action),
    gitHub: gitHubReducer(state.gitHub, action),
    commits: commitsReducer(state.commits, action));
