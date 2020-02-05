import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../actions/github_action.dart';
import '../../actions/db_action.dart';
import '../../actions/routes_action.dart';
import '../../models/app_state.dart';
import '../../models/github.dart';
import 'home_page.dart';

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store) {
        store.dispatch(GitHubOnInitActions(
            pageNumber: 0,
            itemsPerPage: AppState.itemsPerPage,
            updateDate: true));
      },
      rebuildOnChange: true,
      builder: (context, viewModel) {
        return HomePage(
          isLoading: viewModel.store.state.isLoading,
          noError: viewModel.error,
          navigate: viewModel.navigate,
          isDataLoading: viewModel.isDataLoading,
          isNextPageAvailable: viewModel.isNextPageAvailable,
          gitHub: viewModel.gitHub,
          refresh: viewModel.onRefresh,
          loadNextPage: viewModel.onLoadNextPage,
          addToDb: viewModel.onAddToDb,
          deleteFromDb: viewModel.onDeleteFromDb,
          isInBox: viewModel.store.state.isInBox,
        );
      },
    );
  }
}

class _ViewModel {
  final Store<AppState> store;
  final bool error;
  final List<String> route;
  final Function(String, {Object arguments}) navigate;

  final List<GitHub> gitHub;
  final bool isDataLoading;
  final bool isNextPageAvailable;

  _ViewModel({
    @required this.store,
    @required this.error,
    @required this.route,
    @required this.navigate,
    @required this.gitHub,
    @required this.isDataLoading,
    @required this.isNextPageAvailable,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store: store,
      error: store.state.error == null,
      route: store.state.route,
      navigate: (routeName, {arguments}) => store.dispatch(
        NavigatePushAction(routeName, arguments: arguments),
      ),
      gitHub: store.state.gitHub,
      isDataLoading: store.state.isDataLoading,
      isNextPageAvailable: store.state.isNextPageAvailable,
    );
  }

  void onLoadNextPage() {
    if (!isDataLoading && isNextPageAvailable) {
      store.dispatch(
        GitHubOnInitActions(
            pageNumber: gitHub.length ~/ AppState.itemsPerPage,
            itemsPerPage: AppState.itemsPerPage,
            updateDate: false),
      );
    }
  }

  void onRefresh() {
    store.dispatch(
      GitHubOnInitActions(
          pageNumber: 0, itemsPerPage: AppState.itemsPerPage, updateDate: true),
    );
  }

  void onAddToDb(GitHub gitHub) {
    store.dispatch(DbOnAddAction<GitHub>(gitHub));
  }

  void onDeleteFromDb(GitHub gitHub) {
    store.dispatch(DbOnRemoveAction<GitHub>(gitHub));
  }
}
