import 'dart:convert' as convert;

import 'package:redux/redux.dart';
import 'package:http/http.dart';

import '../actions/commits_action.dart';
import '../actions/error_action.dart';
import '../services/github_api.dart';
import '../models/app_state.dart';
import '../models/commits.dart';

void commitsMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is CommitsOnInitActions) {
    if (store.state.commits.isEmpty) {
      store.dispatch(CommitsOnLoadAction());

      List<Commits> commits = new List<Commits>();

      Response commitsResponse = await getCommits(action.fullName);
      if (commitsResponse.statusCode == 200) {
        List list = convert.jsonDecode(commitsResponse.body);

        for (int i = 0; i < commits.length; i++) {
          if (i < 10) {
            commits.add(Commits.fromJson(list[i]));
          }
        }

        store.dispatch(CommitsLoadedAction(commits));
      } else {
        store.dispatch(ErrorOccurredAction(throw Exception(
            'Error getting repositories data, http code: ${commitsResponse.statusCode}.')));
      }
    }
  }

  if (action is CommitsOnDisposeActions) {
    store.state.commits = [];
  }

  next(action);
}
