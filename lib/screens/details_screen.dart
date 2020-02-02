import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/routes_action.dart';
import '../actions/commits_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';
import '../widgets/loading_widget.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GitHub args = ModalRoute.of(context).settings.arguments;

    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        store.dispatch(CommitsOnInitActions(args.fullName));
      },
      onDispose: (store) {
        // TODO m.b. save commits to db
        // store.dispatch(NavigatePopAction());
        store.dispatch(CommitsOnDisposeActions());
      },
      converter: (Store<AppState> store) => store,
      builder: (context, viewModel) => Scaffold(
        // TODO use sliverappbar
        body: Column(
          children: <Widget>[
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Hero(
                    tag: args.id,
                    child: Image.network(
                      args.avatarUrl,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${args.name}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${args.login}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Expanded(
              child: LoadingWidget(
                isLoading: viewModel.state.isLoading,
                child: ListView.builder(
                  itemCount: viewModel.state.commits.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${viewModel.state.commits[index].commit.message}"),
                            Divider(),
                            Text(
                              "${viewModel.state.commits[index].commit.author.name} (${viewModel.state.commits[index].commit.author.email}) on ${viewModel.state.commits[index].commit.author.dateAtFormatted}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
