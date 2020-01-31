import '../models/app_state.dart';

import 'commits_reducer.dart';
import 'loading_reducer.dart';
import 'repositories_reducer.dart';
import 'repository_reducer.dart';

AppState appStateReducer(AppState state, action) => AppState(
      isLoading: loadingReducer(state.isLoading, action),
      repositories: repositoriesReducer(state.repositories, action),
      repository: repositoryReducer(state.repository, action),
      commits: commitsReducer(state.commits, action),
    );
