import 'package:redux/redux.dart';

import '../models/repositories.dart';
import '../actions/repositories_action.dart';

final Reducer<List<Repositories>> repositoriesReducer = combineReducers([
  TypedReducer<List<Repositories>, RepositoriesLoadedAction>(
      _repositoriesLoaded),
]);

List<Repositories> _repositoriesLoaded(
    List<Repositories> repositories, RepositoriesLoadedAction action) {
  return action.repositories;
}
