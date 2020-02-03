import 'package:redux/redux.dart';

import '../models/github.dart';
import '../actions/github_action.dart';

final Reducer<List<GitHub>> gitHubReducer = combineReducers([
  TypedReducer<List<GitHub>, dynamic>(_githubLoaded),
]);

List<GitHub> _githubLoaded(List<GitHub> gitHub, action) {
  // return action.gitHub;

  if (action is GitHubLoadedAction) {
    return List.from(gitHub)..addAll(action.gitHub);
  } else if (action is GitHubOnInitActions && action.pageNumber == 0) {
    return List<GitHub>();
  } else {
    return gitHub;
  }
}
