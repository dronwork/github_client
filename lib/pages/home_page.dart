import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../actions/github_action.dart';
import '../actions/routes_action.dart';
import '../models/app_state.dart';
import '../widgets/text_icon_widget.dart';
import '../widgets/loading_widget.dart';
import '../models/routes.dart';
import '../screens/main_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        store.dispatch(GitHubOnInitActions());
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, viewModel) => LoadingWidget(
        isLoading: viewModel.state.isLoading,
        child: MainScreen(
          body: Center(
            child: ListView.builder(
              itemCount: viewModel.state.gitHub.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => viewModel.navigate(
                    Routes.details,
                    arguments: viewModel.state.gitHub[index],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Hero(
                                  tag: viewModel.state.gitHub[index].id,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.brown.shade800,
                                    child: ClipOval(
                                      child: Image.network(
                                        viewModel.state.gitHub[index].avatarUrl,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${viewModel.state.gitHub[index].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Author: ${viewModel.state.gitHub[index].login}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "Lang: ${viewModel.state.gitHub[index].language}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "${viewModel.state.gitHub[index].description}"),
                          ),
                          Divider(),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextIconWidget(
                                  icon: CommunityMaterialIcons.star_outline,
                                  text:
                                      "${viewModel.state.gitHub[index].stargazersCount} stars",
                                ),
                                TextIconWidget(
                                  icon: CommunityMaterialIcons.source_commit,
                                  text:
                                      "${viewModel.state.gitHub[index].commits} commits",
                                ),
                                TextIconWidget(
                                  icon: CommunityMaterialIcons.source_fork,
                                  text:
                                      "${viewModel.state.gitHub[index].forksCount} forks",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<String> route;
  final Function(String, {Object arguments}) navigate;
  final AppState state;

  _ViewModel({
    @required this.state,
    @required this.route,
    @required this.navigate,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      state: store.state,
      route: store.state.route,
      navigate: (routeName, {arguments}) => store.dispatch(
        NavigatePushAction(routeName, arguments: arguments),
      ),
    );
  }
}
