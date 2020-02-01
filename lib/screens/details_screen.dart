import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../store/actions/commits_action.dart';
import '../store/models/app_state.dart';
import '../widgets/loading_widget.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        store.dispatch(CommitsOnInitActions());
      },
      converter: (Store<AppState> store) => store,
      builder: (context, callback) => Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Image.network(
                      callback.state.gitHub[args].avatarUrl,
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
                              "${callback.state.gitHub[args].name}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${callback.state.gitHub[args].login}",
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
                  isLoading: callback.state.isLoading,
                  child: ListView.builder(
                    itemCount: callback.state.commits.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Text(
                                "${callback.state.commits[index].commit.message}"),
                            Divider(),
                            Text(
                                "${callback.state.commits[index].commit.author.name} (${callback.state.commits[index].commit.author.email})"),
                            Text(
                                "${callback.state.commits[index].commit.author.toDate}"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
