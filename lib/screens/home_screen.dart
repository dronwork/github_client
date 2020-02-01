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
            itemCount: callback.state.repositories.length,
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
                                "Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Lang: Dart",
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
                        child: Text(
                          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
                          'Alps. Situated 1,578 meters above sea level, it is one of the '
                          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
                          'half-hour walk through pastures and pine forest, leads you to the '
                          'lake, which warms to 20 degrees Celsius in the summer. Activities '
                          'enjoyed here include rowing, and riding the summer toboggan run.',
                          softWrap: true,
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextIcon(
                              icon: CommunityMaterialIcons.star,
                              text: "59 stars",
                            ),
                            TextIcon(
                              icon: CommunityMaterialIcons.source_commit,
                              text: "297 commits",
                            ),
                            TextIcon(
                              icon: CommunityMaterialIcons.source_fork,
                              text: "10 forks",
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
