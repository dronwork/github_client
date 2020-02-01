import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../store/models/app_state.dart';
import '../widgets/text_icon.dart';

class HomeScreen extends StatelessWidget {
  static const String tag = "/home";
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (context, callback) => Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: callback.state.gitHub.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            CommunityMaterialIcons.account_circle,
                            size: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${callback.state.gitHub[index].name} (${callback.state.gitHub[index].fullName})",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                        ],
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text("${callback.state.gitHub[index].description}"),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextIcon(
                              icon: CommunityMaterialIcons.star_outline,
                              text:
                                  "${callback.state.gitHub[index].stargazersCount} stars",
                            ),
                            TextIcon(
                              icon: CommunityMaterialIcons.source_commit,
                              text:
                                  "${callback.state.gitHub[index].commits} commits",
                            ),
                            TextIcon(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
