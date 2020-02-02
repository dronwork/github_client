import '../models/commits.dart';

class CommitsOnInitActions {
  final String fullName;

  CommitsOnInitActions(this.fullName);
}

class CommitsOnLoadAction {}

class CommitsLoadedAction {
  final List<Commits> commits;
  CommitsLoadedAction(this.commits);
}

class CommitsFailedAction {}

class CommitsOnDisposeActions {}
