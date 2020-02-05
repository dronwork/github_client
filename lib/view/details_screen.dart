import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/commits_action.dart';
import '../models/app_state.dart';
import '../models/github.dart';
import '../view/widgets/loading_widget.dart';
import '../view/widgets/error_notifier_widget.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GitHub args = ModalRoute.of(context).settings.arguments;

    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        store.dispatch(CommitsOnInitActions(args.fullName));
      },
      onDispose: (store) {
        store.dispatch(CommitsOnDisposeActions());
      },
      converter: (Store<AppState> store) => store,
      builder: (context, viewModel) => Scaffold(
        body: ErrorNotifierWidget(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 280,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.grey,
                  flexibleSpace: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          "${args.login}/${args.name}",
                        ),
                        background: Hero(
                          tag: args.id,
                          child: CachedNetworkImage(
                            imageUrl: args.avatarUrl,
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: LoadingWidget(
              isLoading: viewModel.state.isLoading,
              child: ListView.builder(
                itemCount: viewModel.state.commits.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "${viewModel.state.commits[index].commit.message}"),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${viewModel.state.commits[index].commit.author.name} (${viewModel.state.commits[index].commit.author.email}) on ${viewModel.state.commits[index].commit.author.dateAtFormatted}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
