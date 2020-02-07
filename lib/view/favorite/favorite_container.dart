import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../actions/db_action.dart';
import '../../actions/routes_action.dart';
import '../../models/app_state.dart';
import '../../models/github.dart';
import 'favorite_page.dart';

class FavoriteContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return FavoritePage(
          isLoading: viewModel.store.state.isLoading,
          navigate: viewModel.navigate,
          dbGitHub: viewModel.dbGitHub,
          refresh: viewModel.onRefresh,
          addToDb: viewModel.onAddToDb,
          deleteFromDb: viewModel.onDeleteFromDb,
        );
      },
    );
  }
}

class _ViewModel {
  final Store<AppState> store;
  final List<String> route;
  final Function(String, {Object arguments}) navigate;
  final List<GitHub> dbGitHub;

  _ViewModel({
    @required this.store,
    @required this.route,
    @required this.navigate,
    @required this.dbGitHub,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store: store,
      route: store.state.route,
      navigate: (routeName, {arguments}) =>
          store.dispatch(NavigatePushAction(routeName, arguments: arguments)),
      dbGitHub: store.state.dbGitHub,
    );
  }

  void onRefresh() {
    store.dispatch(DbOnInitAction());
  }

  void onAddToDb(GitHub gitHub) {
    store.dispatch(DbOnAddAction<GitHub>(gitHub));
  }

  void onDeleteFromDb(GitHub gitHub) {
    store.dispatch(DbOnRemoveAction<GitHub>(gitHub));
  }
}
