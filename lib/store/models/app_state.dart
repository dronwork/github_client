import 'package:flutter/foundation.dart';

import 'commits.dart';
import 'github.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<GitHub> gitHub;
  final List<Commits> commits;

  AppState({this.isLoading = false, this.gitHub, this.commits});

  factory AppState.initial() => AppState(
        isLoading: false,
        gitHub: [],
        commits: [],
      );
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}
