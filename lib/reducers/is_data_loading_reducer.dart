import 'package:redux/redux.dart';

import '../actions/error_action.dart';
import '../actions/github_action.dart';

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
