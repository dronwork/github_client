import 'dart:convert' as convert;

import 'package:redux/redux.dart';
import 'package:http/http.dart';

import '../actions/error_action.dart';
import '../actions/github_action.dart';
import '../services/github_api.dart';
import '../models/app_state.dart';
import '../models/repositories.dart';
import '../models/repository.dart';
import '../models/contributors.dart';
import '../models/github.dart';

List<Repositories> _repositories = new List<Repositories>();
List<Repository> _repository = new List<Repository>();
List<Contributors> _contributors = new List<Contributors>();

void githubMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is GitHubOnInitAction) {
    store.dispatch(GitHubOnLoadAction());
    _loadGitHub(action.pageNumber, action.itemsPerPage, action.isUpdateData,
            since: action.since)
        .then((itemsPage) {
      store.dispatch(GitHubLoadedAction(itemsPage));
    }).catchError((exception, stacktrace) {
      store.dispatch(ErrorOccurredAction(exception));
    });
  }

  next(action);
}

Future<List<GitHub>> _loadGitHub(
    int pageNumber, int itemsPerPage, bool isUpdateData,
    {int since = 0}) async {
  List<GitHub> gitHub = new List<GitHub>();

  // Call at data update (Pull-to-refresh)
  if (isUpdateData) {
    // Get a list of all repositories
    Response repositoriesResponse = await getRepositories();
    if (repositoriesResponse.statusCode == 200) {
      List list = convert.jsonDecode(repositoriesResponse.body);
      _repositories =
          list.map((model) => Repositories.fromJson(model)).toList();
    } else {
      throw Exception(
          'Error getting repositories data, http code: ${repositoriesResponse.statusCode}.');
    }
  }

  // Ranks for the loop
  if (pageNumber != 0) {
    pageNumber = pageNumber * itemsPerPage;
    itemsPerPage = itemsPerPage + pageNumber;
  }

  for (int i = pageNumber; i < itemsPerPage; i++) {
    if (i < _repositories.length) {
      // Get information about the repository.
      Response repositoryResponse =
          await getRepository(_repositories[i].fullName);
      if (repositoryResponse.statusCode == 200) {
        _repository.add(
            Repository.fromJson(convert.jsonDecode(repositoryResponse.body)));
      } else {
        throw Exception(
            'Error getting repository data, http code: ${repositoryResponse.statusCode}.');
      }

      // Get the number of commits
      Response contributorsResponse =
          await getContributors(_repositories[i].fullName);
      if (contributorsResponse.statusCode == 200) {
        int commits = 0;
        List list = convert.jsonDecode(contributorsResponse.body);

        list.forEach((v) => commits += Contributors.fromJson(v).contributions);

        _contributors.add(Contributors(contributions: commits));
      } else {
        throw Exception(
            'Error getting contributors data, http code: ${contributorsResponse.statusCode}.');
      }

      // Adding all information to the GitHub model
      gitHub.add(GitHub(
        id: _repositories[i].id,
        fullName: _repositories[i].fullName,
        name: _repository[i].name,
        description: _repository[i].description,
        language: _repository[i].language,
        forksCount: _repository[i].forksCount,
        stargazersCount: _repository[i].stargazersCount,
        login: _repository[i].owner.login,
        avatarUrl: _repository[i].owner.avatarUrl,
        commits: _contributors[i].contributions,
      ));
    }
  }

  return gitHub;
}
