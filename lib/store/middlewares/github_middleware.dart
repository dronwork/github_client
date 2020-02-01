import 'dart:convert' as convert;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repositories.dart';
import '../models/repository.dart';
import '../models/contributors.dart';
import '../models/github.dart';
import '../actions/github_action.dart';
import '../../services/github_api.dart';

void githubMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  List<GitHub> _github = new List<GitHub>();
  List<Repositories> _repositories = new List<Repositories>();
  List<Repository> _repository = new List<Repository>();
  List<Contributors> _contributors = new List<Contributors>();

  if (action is GitHubOnInitActions) {
    if (store.state.gitHub.isEmpty) {
      store.dispatch(GitHubOnLoadAction());

      var _getRepositories = await getRepositories();
      if (_getRepositories.statusCode == 200) {
        List list = convert.jsonDecode(_getRepositories.body);
        _repositories =
            list.map((model) => Repositories.fromJson(model)).toList();
      } else {
        store.dispatch(GitHubFailedAction());
      }

      for (int i = 0; i < 5; i++) {
        var _getRepository = await getRepository(_repositories[i].fullName);
        if (_getRepository.statusCode == 200) {
          _repository.add(
              Repository.fromJson(convert.jsonDecode(_getRepository.body)));
        } else {
          store.dispatch(GitHubFailedAction());
        }

        var _getContributors = await getContributors(_repositories[i].fullName);
        if (_getContributors.statusCode == 200) {
          int commits = 0;
          List list = convert.jsonDecode(_getContributors.body);

          list.forEach(
              (v) => commits += Contributors.fromJson(v).contributions);

          _contributors.add(Contributors(contributions: commits));
        } else {
          store.dispatch(GitHubFailedAction());
        }
      }

      if (_repositories.isNotEmpty &&
          _repository.isNotEmpty &&
          _contributors.isNotEmpty) {
        for (int i = 0; i < 5; i++) {
          _github.add(GitHub(
            id: _repositories[i].id,
            fullName: _repositories[i].fullName,
            name: _repository[i].name,
            description: _repository[i].description,
            language: _repository[i].language,
            forksCount: _repository[i].forksCount,
            stargazersCount: _repository[i].stargazersCount,
            commits: _contributors[i].contributions,
            login: _repository[i].owner.login,
            avatarUrl: _repository[i].owner.avatarUrl,
          ));
        }

        store.dispatch(GitHubLoadedAction(_github));
      } else {
        store.dispatch(GitHubFailedAction());
      }
    }
  }

  next(action);
}
