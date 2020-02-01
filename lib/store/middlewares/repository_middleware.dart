import 'dart:convert' as convert;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repository.dart';
import '../actions/repository_action.dart';
import '../../services/github_api.dart';

void repositoryMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is RepositoryCheckAction) {
    if (store.state.repository.name.isEmpty) {
      store.dispatch(RepositoryOnLoadAction());

      // TODO add fullName
      var response = getRepository("");
      if (response.statusCode == 200) {
        Repository repository =
            Repository.fromJson(convert.jsonDecode(response.body));

        store.dispatch(RepositoryLoadedAction(repository));
      } else {
        store.dispatch(RepositoryFailedAction());
      }
    }
  }
  next(action);
}
