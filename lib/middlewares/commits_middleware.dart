import 'dart:convert' as convert;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/commits.dart';
import '../actions/commits_action.dart';
import '../services/github_api.dart';

void commitsMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  List<Commits> _commits = new List<Commits>();
  if (action is CommitsOnInitActions) {
    if (store.state.commits.isEmpty) {
      store.dispatch(CommitsOnLoadAction());
      var _getCommits = await getCommits(action.fullName);
      if (_getCommits.statusCode == 200) {
        List list = convert.jsonDecode(_getCommits.body);

        for (int i = 0; i < 10; i++) {
          _commits.add(Commits.fromJson(list[i]));
        }

        store.dispatch(CommitsLoadedAction(_commits));
      } else {
        store.dispatch(CommitsFailedAction());
      }
    }
  }

  if (action is CommitsOnDisposeActions) {
    store.state.commits = [];
  }

  next(action);
}
