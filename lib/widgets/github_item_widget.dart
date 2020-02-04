import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'package:flutter/material.dart';

import 'text_icon_widget.dart';
import '../models/github.dart';
import '../models/routes.dart';

class GitHubItemWidget extends StatelessWidget {
  final GitHub gitHub;
  final Function(String, {Object arguments}) onTap;

  const GitHubItemWidget({
    Key key,
    @required this.gitHub,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(Routes.details, arguments: gitHub),
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
                      tag: gitHub.id,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.brown.shade800,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: gitHub.avatarUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
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
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Lang: ${gitHub.language}",
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
    );
  }
}
