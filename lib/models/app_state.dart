import 'package:flutter/foundation.dart';

import 'commits.dart';
import 'github.dart';
import 'routes.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<String> route;
  final List<GitHub> gitHub;
  List<Commits> commits;

  AppState({
    this.isLoading = false,
    this.route,
    this.gitHub,
    this.commits,
  });

  factory AppState.initial() => AppState(
        isLoading: false,
        route: [Routes.home],
        gitHub: [],
        commits: [],
      );
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}