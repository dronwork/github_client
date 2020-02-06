import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'store.dart';
import 'models/app_state.dart';
import 'models/github.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<GitHub>(GitHubAdapter());
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: App(),
    );
  }
}
