import 'package:flutter/foundation.dart';

import 'github.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<GitHub> gitHub;

  AppState({
    this.isLoading = false,
    this.gitHub,
  });

  factory AppState.initial() => AppState(
        isLoading: false,
        gitHub: [],
      );
  factory AppState.loaded() => AppState(
        isLoading: true,
      );
}
