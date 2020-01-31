import '../models/repository.dart';

class RepositoryCheckAction {}

class RepositoryOnLoadAction {}

class RepositoryLoadedAction {
  final Repository repository;
  RepositoryLoadedAction(this.repository);
}

class RepositoryFailedAction {}
