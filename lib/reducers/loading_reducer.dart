import 'package:redux/redux.dart';

import '../actions/github_action.dart';
import '../actions/commits_action.dart';
import '../actions/db_action.dart';
import '../actions/error_action.dart';

final loadingReducer = combineReducers<bool>([
  /**
   * On Load @isLoading true
  */
  TypedReducer<bool, GitHubOnLoadAction>(_loading),
  TypedReducer<bool, CommitsOnLoadAction>(_loading),
  TypedReducer<bool, DbOnLoadAction>(_loading),
  /**
   * Loaded @isloading false
  */
  TypedReducer<bool, GitHubLoadedAction>(_loaded),
  TypedReducer<bool, CommitsLoadedAction>(_loaded),
  TypedReducer<bool, DbLoadedAction>(_loaded),
  TypedReducer<bool, ErrorOccurredAction>(_loaded),
]);

bool _loading(bool state, action) {
  return true;
}

bool _loaded(bool state, action) {
  return false;
}
