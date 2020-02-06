import 'package:flutter/material.dart';

import '../widgets/github_item_widget.dart';
import '../widgets/loading_widget.dart';
import '../../models/github.dart';
import '../../view/main_screen.dart';
import '../../utils/preloader.dart';

class HomePage extends StatefulWidget {
  final bool isLoading;
  final bool noError;
  final Function(String, {Object arguments}) navigate;
  final bool isNextPageAvailable;
  final List<GitHub> gitHub;
  final Function refresh;
  final Function loadNextPage;
  final Function addToDb;
  final Function deleteFromDb;
  final bool isInBox;

  const HomePage({
    Key key,
    @required this.isLoading,
    @required this.noError,
    @required this.navigate,
    @required this.isNextPageAvailable,
    @required this.gitHub,
    @required this.refresh,
    @required this.loadNextPage,
    @required this.addToDb,
    @required this.deleteFromDb,
    @required this.isInBox,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  final _scrollThresholdInPixels = 100.0;
  final _preloader = Preloader(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: LoadingWidget(
          isLoading: widget.isLoading && widget.gitHub.length == 0,
          child: ListView.builder(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: widget.isNextPageAvailable
                ? widget.gitHub.length + 1
                : widget.gitHub.length,
            itemBuilder: (context, index) {
              if (index < widget.gitHub.length) {
                return GitHubItemWidget(
                  onTap: widget.navigate,
                  gitHub: widget.gitHub[index],
                  addToDb: widget.addToDb,
                  deleteFromDb: widget.deleteFromDb,
                  isInBox: widget.isInBox,
                );
              } else if (widget.gitHub.length != 0) {
                return Center(child: CircularProgressIndicator());
              } else if (widget.gitHub.length == 0 && !widget.isLoading) {
                return Center(child: Text("Null data"));
              }
            },
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThresholdInPixels &&
        !widget.isLoading) {
      _preloader.run(() => widget.loadNextPage());
    }
  }

  Future _onRefresh() {
    widget.refresh();
    return Future.value();
  }
}
