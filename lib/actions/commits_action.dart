import '../models/commits.dart';

class CommitsOnInitAction {
  final String fullName;

  CommitsOnInitAction(this.fullName);
}

class CommitsOnLoadAction {}

class CommitsLoadedAction {
  final List<Commits> commits;
  CommitsLoadedAction(this.commits);
}

class CommitsOnDisposeAction {}
