import 'package:flutter/material.dart';

import '../../widgets/github_item_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../models/github.dart';
import '../../view/main_screen.dart';

class FavoritePage extends StatefulWidget {
  final bool isLoading;
  final bool noError;
  final Function(String, {Object arguments}) navigate;
  final List<GitHub> gitHub;
  final Function refresh;
  final Function addToDb;
  final Function deleteFromDb;

  const FavoritePage({
    Key key,
    @required this.isLoading,
    @required this.noError,
    @required this.navigate,
    @required this.gitHub,
    @required this.refresh,
    @required this.addToDb,
    @required this.deleteFromDb,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: LoadingWidget(
          isLoading: widget.isLoading,
          child: ListView.builder(
            itemCount: widget.gitHub.length,
            itemBuilder: (context, index) {
              return GitHubItemWidget(
                onTap: widget.navigate,
                gitHub: widget.gitHub[index],
                addToDb: widget.addToDb,
                deleteFromDb: widget.deleteFromDb,
              );
            },
          ),
        ),
      ),
    );
  }

  Future _onRefresh() {
    widget.refresh();
    return Future.value();
  }
}
