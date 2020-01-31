import '../models/repositories.dart';

class RepositoriesOnInitActions {}

class RepositoriesOnLoadAction {}

class RepositoriesLoadedAction {
  final List<Repositories> repositories;
  RepositoriesLoadedAction(
    this.repositories,
  );
}

class RepositoriesFailedAction {}
