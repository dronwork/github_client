import 'package:redux/redux.dart';

import '../actions/github_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';

final Reducer<List<GitHub>> gitHubReducer = combineReducers([
  TypedReducer<List<GitHub>, dynamic>(_githubLoaded),
]);

List<GitHub> _githubLoaded(List<GitHub> gitHub, action) {
  if (action is GitHubLoadedAction) {
    return List.from(gitHub)..addAll(action.gitHub);
  } else if (action is GitHubOnInitAction &&
      action.isUpdateData &&
      !action.isInitData) {
    return List<GitHub>();
  } else {
    return gitHub;
  }
}

final Reducer<bool> isNextPageAvailableReducer = combineReducers<bool>([
  TypedReducer<bool, GitHubLoadedAction>(_isNextPageAvailable),
]);

bool _isNextPageAvailable(bool isNextPageAvailable, dynamic action) {
  return (action is GitHubLoadedAction)
      ? action.gitHub.length == AppState.itemsPerPage
      : isNextPageAvailable;
}
