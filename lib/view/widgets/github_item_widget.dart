import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'text_icon_widget.dart';
import '../../models/github.dart';
import '../../models/routes.dart';

class GitHubItemWidget extends StatelessWidget {
  final GitHub gitHub;
  final Function(String, {Object arguments}) onTap;
  final Function addToDb;
  final Function deleteFromDb;
  final bool isInBox;

  const GitHubItemWidget({
    Key key,
    @required this.gitHub,
    @required this.onTap,
    @required this.addToDb,
    @required this.deleteFromDb,
    @required this.isInBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(Routes.details, arguments: gitHub),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          (isInBox || gitHub.isInBox)
              ? IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => deleteFromDb(gitHub),
                )
              : IconSlideAction(
                  caption: 'Add',
                  color: Colors.green,
                  icon: Icons.add,
                  onTap: () => addToDb(gitHub),
                ),
        ],
        child: Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Hero(
                        tag: gitHub.id,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: gitHub.avatarUrl,
                              placeholder: (context, url) =>
                                  Icon(Icons.person, color: Colors.grey[400]),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                            "${gitHub.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Author: ${gitHub.login}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Lang: ${gitHub.language}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text("${gitHub.description}"),
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextIconWidget(
                        icon: CommunityMaterialIcons.star_outline,
                        text: "${gitHub.stargazersCount} stars",
                      ),
                      TextIconWidget(
                        icon: CommunityMaterialIcons.source_commit,
                        text: "${gitHub.commits} commits",
                      ),
                      TextIconWidget(
                        icon: CommunityMaterialIcons.source_fork,
                        text: "${gitHub.forksCount} forks",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
