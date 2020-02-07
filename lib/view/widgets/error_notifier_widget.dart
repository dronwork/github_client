import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../actions/error_action.dart';
import '../../models/app_state.dart';

class ErrorNotifierWidget extends StatelessWidget {
  ErrorNotifierWidget({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, viewModel) => child,
      onDidChange: (viewModel) {
        if (viewModel.error != null) {
          viewModel.markErrorAsHandled();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(viewModel.error.toString()),
            ),
          );
        }
      },
      distinct: true,
    );
  }
}

class _ViewModel {
  _ViewModel({
    this.markErrorAsHandled,
    this.error,
  });

  final Function markErrorAsHandled;
  final Exception error;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      markErrorAsHandled: () => store.dispatch(ErrorHandledAction()),
      error: store.state.error,
    );
  }
}
