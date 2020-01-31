import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/commits.dart';
import '../actions/commits_action.dart';

void commitsMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is CommitsCheckAction) {
    if (store.state.commits.commitsCount == null) {
      store.dispatch(CommitsOnLoadAction());

      // TODO /repos/$full_name/commits
    }
  }
  next(action);
}
