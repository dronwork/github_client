import 'package:redux/redux.dart';

import '../actions/github_action.dart';

final loadingReducer = combineReducers<bool>([
  /**
   * On Load @isLoading true
  */
  TypedReducer<bool, GitHubOnLoadAction>(_loading),
  /**
   * Loaded @isloading false
  */
  TypedReducer<bool, GitHubLoadedAction>(_loaded),
  TypedReducer<bool, GitHubFailedAction>(_loaded),
]);

bool _loading(bool state, action) {
  return true;
}

bool _loaded(bool state, action) {
  return false;
}
