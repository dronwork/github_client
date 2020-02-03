import 'package:flutter/foundation.dart';

import 'commits.dart';
import 'github.dart';
import 'routes.dart';

class AppState {
  // App
  final bool isLoading;
  final Exception error;
  // Routes
  final List<String> route;
  // GitHub data
  final List<GitHub> gitHub;
  List<Commits> commits;
  final bool isDataLoading;
  final bool isNextPageAvailable;
  static const int itemsPerPage = 5;

  AppState({
    this.isLoading = false,
    this.error,
    this.route,
    this.gitHub,
    this.commits,
    this.isDataLoading,
    this.isNextPageAvailable,
  });

  factory AppState.initial() => AppState(
        isLoading: false,
        route: [Routes.home],
        gitHub: [],
        commits: [],
        isDataLoading: false,
        isNextPageAvailable: false,
      );
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}
