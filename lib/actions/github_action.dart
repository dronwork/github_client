import 'package:flutter/widgets.dart';

import '../models/github.dart';

class GitHubOnInitActions {
  final int pageNumber;
  final int itemsPerPage;
  final bool isUpdateData;
  final bool isInitData;
  final int since;

  GitHubOnInitActions({
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
