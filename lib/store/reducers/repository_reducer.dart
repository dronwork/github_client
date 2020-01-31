import 'package:redux/redux.dart';

import '../models/repository.dart';
import '../actions/repository_action.dart';

final Reducer<Repository> repositoryReducer = combineReducers([
  TypedReducer<Repository, RepositoryLoadedAction>(_repositoryLoaded),
]);

Repository _repositoryLoaded(
    Repository repositoryUser, RepositoryLoadedAction action) {
  return action.repository;
}
