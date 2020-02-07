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
      builder: (context, viewModel) {
        return HomePage(
          isLoading: viewModel.isLoading,
          navigate: viewModel.navigate,
          isNextPageAvailable: viewModel.isNextPageAvailable,
          gitHub: viewModel.gitHub,
          refresh: viewModel.onRefresh,
          loadNextPage: viewModel.onLoadNextPage,
          addToDb: viewModel.onAddToDb,
          deleteFromDb: viewModel.onDeleteFromDb,
        );
      },
    );
  }
}

class _ViewModel {
  final Store<AppState> store;

  final bool isLoading;
  final List<String> route;
  final Function(String, {Object arguments}) navigate;

  final List<GitHub> gitHub;
  final bool isNextPageAvailable;

  _ViewModel({
    @required this.store,
    @required this.route,
    @required this.navigate,
    @required this.gitHub,
    @required this.isLoading,
    @required this.isNextPageAvailable,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store: store,
      route: store.state.route,
      navigate: (routeName, {arguments}) => store.dispatch(
        NavigatePushAction(routeName, arguments: arguments),
      ),
      gitHub: store.state.gitHub,
      isLoading: store.state.isLoading,
      isNextPageAvailable: store.state.isNextPageAvailable,
    );
  }

  void onLoadNextPage() {
    if (!isLoading && isNextPageAvailable) {
      store.dispatch(
        GitHubOnInitAction(
          pageNumber: store.state.gitHub.length ~/ AppState.itemsPerPage,
          itemsPerPage: AppState.itemsPerPage,
          isUpdateData: false,
        ),
      );
    }
  }

  void onRefresh() {
    store.dispatch(
      GitHubOnInitAction(
        pageNumber: 0,
        itemsPerPage: AppState.itemsPerPage,
        isUpdateData: true,
      ),
    );
  }

  void onAddToDb(GitHub gitHub) {
    store.dispatch(DbOnAddAction<GitHub>(gitHub));
  }

  void onDeleteFromDb(GitHub gitHub) {
    store.dispatch(DbOnRemoveAction<GitHub>(gitHub));
  }
}
