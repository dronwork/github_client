import 'package:flutter/foundation.dart';

import 'commits.dart';
import 'repositories.dart';
import 'repository.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Repositories> repositories;
  final Repository repository;
  final Commits commits;

  AppState({
    this.isLoading = false,
    this.repositories,
    this.repository,
    this.commits,
  });

  factory AppState.initial() => AppState(
        isLoading: false,
        repositories: [],
        repository: Repository(),
        commits: Commits(),
      );
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}
