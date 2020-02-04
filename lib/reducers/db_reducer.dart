import 'package:redux/redux.dart';

import '../actions/db_action.dart';
import '../models/github.dart';

final Reducer<List<GitHub>> dbReducer = combineReducers([
  TypedReducer<List<GitHub>, DbLoadedActions<GitHub>>(_dbLoaded),
]);

List<GitHub> _dbLoaded(List<GitHub> gitHub, DbLoadedActions<GitHub> action) {
  return action.model;
}
