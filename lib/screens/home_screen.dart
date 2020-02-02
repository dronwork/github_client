import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../store/models/app_state.dart';
import '../widgets/text_icon_widget.dart';
import '../widgets/loading_widget.dart';
import '../utils/routes_path.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (context, callback) => LoadingWidget(
        isLoading: callback.state.isLoading,
        child: Scaffold(
          body: Center(
            child: ListView.builder(
              itemCount: callback.state.gitHub.length,
              itemBuilder: (context, index) {
                return InkWell(
                  // TODO: Bad practice, we need to change navigation to redux. When there's time...
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesPach.details,
                    arguments: {
                      "avatarUrl": callback.state.gitHub[index].avatarUrl,
                      "name": callback.state.gitHub[index].name,
                      "fullName": callback.state.gitHub[index].fullName,
                      "login": callback.state.gitHub[index].login
                    },
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
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.brown.shade800,
                                  child: ClipOval(
                                    child: Image.network(
                                      callback.state.gitHub[index].avatarUrl,
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
                                      "${callback.state.gitHub[index].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Author: ${callback.state.gitHub[index].login}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "Lang: ${callback.state.gitHub[index].language}",
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
                                "${callback.state.gitHub[index].description}"),
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
                                      "${callback.state.gitHub[index].stargazersCount} stars",
                                ),
                                TextIconWidget(
                                  icon: CommunityMaterialIcons.source_commit,
                                  text:
                                      "${callback.state.gitHub[index].commits} commits",
                                ),
                                TextIconWidget(
                                  icon: CommunityMaterialIcons.source_fork,
                                  text:
                                      "${callback.state.gitHub[index].forksCount} forks",
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
