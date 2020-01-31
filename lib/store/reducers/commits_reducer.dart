import 'package:redux/redux.dart';

import '../models/commits.dart';
import '../actions/commits_action.dart';

final Reducer<Commits> commitsReducer = combineReducers([
  TypedReducer<Commits, CommitsLoadedAction>(_commitsLoaded),
]);

Commits _commitsLoaded(Commits commits, CommitsLoadedAction action) {
  return action.commits;
}
