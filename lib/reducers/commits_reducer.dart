import 'package:redux/redux.dart';

import '../models/commits.dart';
import '../actions/commits_action.dart';

final Reducer<List<Commits>> commitsReducer = combineReducers([
  TypedReducer<List<Commits>, CommitsLoadedAction>(_commitsLoaded),
]);

List<Commits> _commitsLoaded(
    List<Commits> commits, CommitsLoadedAction action) {
  return action.commits;
}
