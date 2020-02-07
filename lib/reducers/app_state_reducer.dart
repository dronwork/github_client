import 'db_reducer.dart';
import 'loading_reducer.dart';
import 'error_reducer.dart';
import 'navigators_reducer.dart';
import 'github_reducer.dart';
import 'commits_reducer.dart';
import '../models/app_state.dart';

AppState appStateReducer(AppState state, action) => AppState(
      isLoading: loadingReducer(state.isLoading, action),
      error: errorReducer(state.error, action),
      route: navigatorsReducer(state.route, action),
      gitHub: gitHubReducer(state.gitHub, action),
      isNextPageAvailable:
          isNextPageAvailableReducer(state.isNextPageAvailable, action),
      commits: commitsReducer(state.commits, action),
      dbGitHub: dbReducer(state.dbGitHub, action),
    );
