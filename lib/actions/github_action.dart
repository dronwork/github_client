import 'package:flutter/widgets.dart';

import '../models/github.dart';

class GitHubOnInitActions {
  final int pageNumber;
  final int itemsPerPage;
  final bool updateDate;
  final bool init;
  final int since;

  GitHubOnInitActions({
    @required this.pageNumber,
    @required this.itemsPerPage,
    @required this.updateDate,
    this.init = false,
    this.since,
  });
}

class GitHubOnLoadAction {}

class GitHubLoadedAction {
  final List<GitHub> gitHub;
  GitHubLoadedAction(this.gitHub);
}
