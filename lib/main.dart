import 'package:flutter/material.dart';
import 'package:github_client/screens/home_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'store/store.dart';
import 'store/actions/github_action.dart';
import 'store/models/app_state.dart';
import 'routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: StoreConnector<AppState, Store<AppState>>(
          onInit: (store) {
            store.dispatch(GitHubOnInitActions());
          },
          converter: (Store<AppState> store) => store,
          builder: (context, store) => HomeScreen(),
        ),
        routes: routes,
      ),
    );
  }
}
