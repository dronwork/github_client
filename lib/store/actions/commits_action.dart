import '../models/commits.dart';

class CommitsCheckAction {}

class CommitsOnLoadAction {}

class CommitsLoadedAction {
  final Commits commits;
  CommitsLoadedAction(this.commits);
}

class CommitsFailedAction {}
