import 'package:flutter/widgets.dart';

import '../models/github.dart';

class GitHubOnInitAction {
  final int pageNumber;
  final int itemsPerPage;
  final bool isUpdateData;
  final bool isInitData;
  final int since;

  GitHubOnInitAction({
    @required this.pageNumber,
    @required this.itemsPerPage,
    @required this.isUpdateData,
    this.isInitData = false,
    this.since = 0,
  });
}

class GitHubOnLoadAction {}

class GitHubLoadedAction {
  final List<GitHub> gitHub;
  GitHubLoadedAction(this.gitHub);
}
