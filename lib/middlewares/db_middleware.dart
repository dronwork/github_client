import 'package:redux/redux.dart';
import 'package:hive/hive.dart';

import '../actions/db_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';
import '../utils/consts.dart';

void dbMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  Box<GitHub> gitHubBox = await Hive.openBox<GitHub>(dbName);

  if (action is DbOnInitActions) {
    store.dispatch(DbOnLoadAction());
    store.dispatch(DbLoadedAction<GitHub>(gitHubBox.values.toList()));
    // store.dispatch(DbIsInBoxAction(_listsEqual(store)));
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

  next(action);
}

bool _listsEqual(Store<AppState> store) {
  var i = -1;
  // TODO Debug
  return store.state.gitHub.every((v) {
    i++;
    return store.state.dbGitHub[i].id == v.id;
  });
}
