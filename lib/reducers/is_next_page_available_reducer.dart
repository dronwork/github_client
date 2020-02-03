import 'package:redux/redux.dart';

import '../actions/github_action.dart';
import '../models/app_state.dart';

final Reducer<bool> isNextPageAvailableReducer = combineReducers<bool>([
  TypedReducer<bool, GitHubLoadedAction>(_isNextPageAvailable),
]);

bool _isNextPageAvailable(bool isNextPageAvailable, dynamic action) {
  return (action is GitHubLoadedAction)
      ? action.gitHub.length == AppState.itemsPerPage
      : isNextPageAvailable;
}
