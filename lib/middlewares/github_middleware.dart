import 'dart:convert' as convert;

import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/repositories.dart';
import '../models/repository.dart';
import '../models/contributors.dart';
import '../models/github.dart';
import '../actions/github_action.dart';
import '../services/github_api.dart';

void githubMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action is GitHubOnInitActions) {
    if (store.state.gitHub.isEmpty) {
      store.dispatch(GitHubOnLoadAction());
      List<Repositories> repositories = new List<Repositories>();
      List<Repository> repository = new List<Repository>();
      List<Contributors> contributors = new List<Contributors>();
      List<GitHub> github = new List<GitHub>();

      // Get a list of all repositories
      var _getRepositories = await getRepositories();
      if (_getRepositories.statusCode == 200) {
        List list = convert.jsonDecode(_getRepositories.body);
        repositories =
            list.map((model) => Repositories.fromJson(model)).toList();
      } else {
        store.dispatch(GitHubFailedAction());
      }

      for (int i = 0; i < 5; i++) {
        // Get information about the repository.
        var _getRepository = await getRepository(repositories[i].fullName);
        if (_getRepository.statusCode == 200) {
          repository.add(
              Repository.fromJson(convert.jsonDecode(_getRepository.body)));
        } else {
          store.dispatch(GitHubFailedAction());
        }

        // Get the number of commits
        var _getContributors = await getContributors(repositories[i].fullName);
        if (_getContributors.statusCode == 200) {
          int commits = 0;
          List list = convert.jsonDecode(_getContributors.body);

          list.forEach(
              (v) => commits += Contributors.fromJson(v).contributions);

          contributors.add(Contributors(contributions: commits));
        } else {
          store.dispatch(GitHubFailedAction());
        }

        // Adding all information to the Github model
        if (repositories[i].fullName.isNotEmpty &&
            repository[i].name.isNotEmpty &&
            contributors[i].contributions != 0) {
          github.add(GitHub(
            id: repositories[i].id,
            fullName: repositories[i].fullName,
            name: repository[i].name,
            description: repository[i].description,
            language: repository[i].language,
            forksCount: repository[i].forksCount,
            stargazersCount: repository[i].stargazersCount,
            login: repository[i].owner.login,
            avatarUrl: repository[i].owner.avatarUrl,
            commits: contributors[i].contributions,
          ));

          store.dispatch(GitHubLoadedAction(github));
        } else {
          store.dispatch(GitHubFailedAction());
        }
      }
    }
  }

  next(action);
}
