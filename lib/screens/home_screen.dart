import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../store/models/app_state.dart';

class HomeScreen extends StatelessWidget {
  static String tag = "/home_page";
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (Store<AppState> store) => store,
        builder: (context, callback) => Scaffold(
              body: Container(
                child: Center(
                  child: Text("Test"),
                ),
              ),
            ));
  }
}
