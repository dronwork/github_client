import '../models/commits.dart';

class CommitsOnInitActions {}

class CommitsOnLoadAction {}

class CommitsLoadedAction {
  final List<Commits> commits;
  CommitsLoadedAction(
    this.commits,
  );
}

class CommitsFailedAction {}
