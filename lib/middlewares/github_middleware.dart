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

List<Repositories> repositories = new List<Repositories>();
List<Repository> repository = new List<Repository>();
List<Contributors> contributors = new List<Contributors>();

void githubMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is GitHubOnInitAction) {
    store.dispatch(GitHubOnLoadAction());
    _loadGitHubData(action.pageNumber, action.itemsPerPage, action.isUpdateData,
            since: action.since)
        .then((itemsPage) {
      store.dispatch(GitHubLoadedAction(itemsPage));
    }).catchError((exception, stacktrace) {
      store.dispatch(ErrorOccurredAction(exception));
    });
  }

  next(action);
}

Future<List<GitHub>> _loadGitHubData(int page, int perPage, bool updateDate,
    {int since = 0}) async {
  List<GitHub> gitHub = new List<GitHub>();

  // Call at data update (Pull-to-refresh)
  if (updateDate) {
    // Get a list of all repositories
    Response repositoriesResponse = await getRepositories();
    if (repositoriesResponse.statusCode == 200) {
      List list = convert.jsonDecode(repositoriesResponse.body);
      repositories = list.map((model) => Repositories.fromJson(model)).toList();
    } else {
      throw Exception(
          'Error getting repositories data, http code: ${repositoriesResponse.statusCode}.');
    }
  }

  // Ranks for the loop
  if (page != 0) {
    page = page * perPage;
    perPage = perPage + page;
  }

  for (int i = page; i < perPage; i++) {
    if (i < repositories.length) {
      // Get information about the repository.
      Response repositoryResponse =
          await getRepository(repositories[i].fullName);
      if (repositoryResponse.statusCode == 200) {
        repository.add(
            Repository.fromJson(convert.jsonDecode(repositoryResponse.body)));
      } else {
        throw Exception(
            'Error getting repository data, http code: ${repositoryResponse.statusCode}.');
      }

      // Get the number of commits
      Response contributorsResponse =
          await getContributors(repositories[i].fullName);
      if (contributorsResponse.statusCode == 200) {
        int commits = 0;
        List list = convert.jsonDecode(contributorsResponse.body);

        list.forEach((v) => commits += Contributors.fromJson(v).contributions);

        contributors.add(Contributors(contributions: commits));
      } else {
        throw Exception(
            'Error getting contributors data, http code: ${contributorsResponse.statusCode}.');
      }

      // Adding all information to the GitHub model
      gitHub.add(GitHub(
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
    }
  }

  return gitHub;
}
