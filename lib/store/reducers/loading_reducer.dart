import 'package:redux/redux.dart';

import '../actions/repositories_action.dart';
import '../actions/repository_action.dart';
import '../actions/commits_action.dart';

final loadingReducer = combineReducers<bool>([
  /**
   * On Load @isLoading true
  */
  TypedReducer<bool, RepositoriesOnLoadAction>(_loading),
  TypedReducer<bool, RepositoryOnLoadAction>(_loading),
  TypedReducer<bool, CommitsOnLoadAction>(_loading),
  /**
   * Loaded @isloading false
  */
  TypedReducer<bool, RepositoriesLoadedAction>(_loaded),
  TypedReducer<bool, RepositoriesFailedAction>(_loaded),
  TypedReducer<bool, RepositoryLoadedAction>(_loaded),
  TypedReducer<bool, RepositoryFailedAction>(_loaded),
  TypedReducer<bool, CommitsLoadedAction>(_loaded),
  TypedReducer<bool, CommitsFailedAction>(_loaded),
]);

bool _loading(bool state, action) {
  return true;
}

bool _loaded(bool state, action) {
  return false;
}
