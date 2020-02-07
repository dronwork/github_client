import 'package:redux/redux.dart';
import 'package:hive/hive.dart';

import '../actions/db_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';
import '../utils/consts.dart';

void dbMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  Box<GitHub> gitHubBox = await Hive.openBox<GitHub>(dbName);

  if (action is DbOnInitAction) {
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

  next(action);
}
