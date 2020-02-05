import 'package:redux/redux.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../actions/db_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';

void dbMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  Box<GitHub> gitHubBox = await _gitHubBox();

  if (action is DbOnInitActions) {
    store.dispatch(DbOnLoadAction());
    store.dispatch(DbLoadedAction<GitHub>(gitHubBox.values.toList()));
  }

  if (action is DbOnAddAction<GitHub>) {
    store.dispatch(DbOnLoadAction());
    gitHubBox.add(action.model);
    store.dispatch(DbLoadedAction<GitHub>(gitHubBox.values.toList()));
  }

  if (action is DbOnRemoveAction<GitHub>) {
    store.dispatch(DbOnLoadAction());
    if (action.model.isInBox) {
      gitHubBox.delete(action.model.key);
      if (gitHubBox.length == 0) gitHubBox.clear();
    }
    store.dispatch(DbLoadedAction<GitHub>(gitHubBox.values.toList()));
  }

  if (action is DbIsInBoxAction) {
    store.dispatch(DbIsInBoxAction(_listsEqual(store)));
  }

  next(action);
}

Future<Box<GitHub>> _gitHubBox() async {
  const String _DB_NAME = "github_box";
  if (!Hive.isBoxOpen(_DB_NAME)) {
    await Hive.initFlutter();
    Hive.registerAdapter(GitHubAdapter());
  }

  return await Hive.openBox(_DB_NAME);
}

bool _listsEqual(Store<AppState> store) {
  var i = -1;
  return store.state.gitHub.every((v) {
    i++;
    return store.state.dbGitHub[i].id == v.id;
  });
}
