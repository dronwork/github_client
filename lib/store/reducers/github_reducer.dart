import 'package:redux/redux.dart';

import '../models/github.dart';
import '../actions/github_action.dart';

final Reducer<List<GitHub>> gitHubReducer = combineReducers([
  TypedReducer<List<GitHub>, GitHubLoadedAction>(_githubLoaded),
]);

List<GitHub> _githubLoaded(List<GitHub> github, GitHubLoadedAction action) {
  return action.gitHub;
}
