import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/routes_action.dart';
import '../models/app_state.dart';
import '../models/routes.dart';

class BottomNavBar extends StatelessWidget {
  Widget _addPadding(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: child,
      );

  Widget _getMenuItem(BuildContext context,
      {Icon icon, String routeName, @required _ViewModel viewModel}) {
    if (!viewModel.route.contains(routeName)) {
      return _addPadding(
        IconButton(
          icon: icon,
          onPressed: () => viewModel.navigate(routeName),
        ),
      );
    } else {
      return _addPadding(
        IconButton(
          icon: icon,
          onPressed: () => viewModel.navigate(routeName),
          color: Theme.of(context).accentColor.withOpacity(0.7),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      child: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, viewModel) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getMenuItem(
              context,
              icon: Icon(Icons.home),
              routeName: Routes.home,
              viewModel: viewModel,
            ),
            _getMenuItem(
              context,
              icon: Icon(Icons.favorite),
              routeName: Routes.favorite,
              viewModel: viewModel,
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<String> route;
  final Function(String) navigate;

  _ViewModel({@required this.route, @required this.navigate});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      route: store.state.route,
      navigate: (routeName) => store.dispatch(
        NavigateReplaceAction(routeName),
      ),
    );
  }
}
