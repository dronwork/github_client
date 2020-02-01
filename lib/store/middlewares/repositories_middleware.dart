import 'dart:convert' as convert;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repositories.dart';
import '../actions/repositories_action.dart';
import '../../services/github_api.dart';

void repositoriesMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is RepositoriesOnInitActions) {
    if (store.state.repositories.isEmpty) {
      store.dispatch(RepositoriesOnLoadAction());
      // TODO все запросы в одном Middleware
      // TODO since
      var response = await getRepositories();
      if (response.statusCode == 200) {
        List list = convert.jsonDecode(response.body);
        List<Repositories> repositories =
            list.map((model) => Repositories.fromJson(model)).toList();

        store.dispatch(RepositoriesLoadedAction(repositories));
      } else {
        store.dispatch(RepositoriesFailedAction());
      }
    }
  }
  next(action);
}
