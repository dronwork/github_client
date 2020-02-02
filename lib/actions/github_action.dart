import '../models/github.dart';

class GitHubOnInitActions {}

class GitHubOnLoadAction {}

class GitHubLoadedAction {
  final List<GitHub> gitHub;
  GitHubLoadedAction(
    this.gitHub,
  );
}

class GitHubFailedAction {}
