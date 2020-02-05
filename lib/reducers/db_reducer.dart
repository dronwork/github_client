import 'package:redux/redux.dart';

import '../actions/db_action.dart';
import '../models/github.dart';

final Reducer<List<GitHub>> dbReducer = combineReducers([
  TypedReducer<List<GitHub>, DbLoadedAction<GitHub>>(_dbLoaded),
]);

List<GitHub> _dbLoaded(List<GitHub> gitHub, DbLoadedAction<GitHub> action) {
  return action.model;
}

final Reducer<bool> dbIsBoxReducer = combineReducers([
  TypedReducer<bool, DbIsInBoxAction>(_dbIsBox),
]);

bool _dbIsBox(bool gitHub, DbIsInBoxAction action) {
  return action.isInBox;
}
