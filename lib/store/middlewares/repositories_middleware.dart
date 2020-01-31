import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repositories.dart';
import '../actions/repositories_action.dart';

void repositoriesMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is RepositoriesOnInitActions) {
    if (store.state.repositories.isEmpty) {
      store.dispatch(RepositoriesOnLoadAction());

      // TODO /repositories
    }
  }
  next(action);
}
