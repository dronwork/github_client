import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repository.dart';
import '../actions/repository_action.dart';

void repositoryMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is RepositoryCheckAction) {
    if (store.state.repository.name.isEmpty) {
      store.dispatch(RepositoryOnLoadAction());

      // TODO /repos/$full_name
    }
  }
  next(action);
}
