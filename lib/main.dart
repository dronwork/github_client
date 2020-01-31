import 'package:flutter/material.dart';
import 'package:github_client/screens/home_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'store/store.dart';
import 'store/actions/repositories_action.dart';
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
            store.dispatch(RepositoriesOnInitActions());
          },
          converter: (Store<AppState> store) => store,
          builder: (context, store) => _widget(store),
        ),
        routes: routes,
      ),
    );
  }

  Widget _widget(Store<AppState> store) {
    if (store.state.repositories == null) {
      return Text("null");
    }
    return HomeScreen();
  }
}
