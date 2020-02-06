import 'package:flutter/foundation.dart';

import 'commits.dart';
import 'github.dart';
import 'routes.dart';

@immutable
class AppState {
  // App
  final bool isLoading;
  final Exception error;
  // Routes
  final List<String> route;
  // GitHub data
  static const int itemsPerPage = 5;
  final List<GitHub> gitHub;
  final bool isNextPageAvailable;
  final List<Commits> commits;
  // Hive
  final List<GitHub> dbGitHub;
  final bool isInBox;

  AppState({
    this.isLoading = false,
    this.error,
    this.route,
    this.gitHub,
    this.commits,
    this.isNextPageAvailable,
    this.dbGitHub,
    this.isInBox,
  });

  factory AppState.initial() => AppState(
      isLoading: false,
      route: [Routes.home],
      gitHub: [],
      commits: [],
      isNextPageAvailable: false,
      dbGitHub: [],
      isInBox: false);
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}
