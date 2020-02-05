import 'package:redux/redux.dart';

import '../actions/github_action.dart';
import '../actions/error_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';

final Reducer<List<GitHub>> gitHubReducer = combineReducers([
  TypedReducer<List<GitHub>, dynamic>(_githubLoaded),
]);

List<GitHub> _githubLoaded(List<GitHub> gitHub, action) {
  if (action is GitHubLoadedAction) {
    return List.from(gitHub)..addAll(action.gitHub);
  } else if (action is GitHubOnInitActions && action.pageNumber == 0) {
    return List<GitHub>();
  } else {
    return gitHub;
  }
}

final Reducer<bool> isDataLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, GitHubOnInitActions>(_isDataLoadingStartedReducer),
  TypedReducer<bool, GitHubLoadedAction>(_isDataLoadingFinishedReducer),
  TypedReducer<bool, ErrorOccurredAction>(_isDataLoadingFinishedReducer),
]);

bool _isDataLoadingStartedReducer(bool _, dynamic action) {
  return true;
}

bool _isDataLoadingFinishedReducer(bool _, dynamic action) {
  return false;
}

final Reducer<bool> isNextPageAvailableReducer = combineReducers<bool>([
  TypedReducer<bool, GitHubLoadedAction>(_isNextPageAvailable),
]);

bool _isNextPageAvailable(bool isNextPageAvailable, dynamic action) {
  return (action is GitHubLoadedAction)
      ? action.gitHub.length == AppState.itemsPerPage
      : isNextPageAvailable;
}
