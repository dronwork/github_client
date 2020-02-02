class NavigateReplaceAction {
  final String routeName;
  final Object arguments;

  NavigateReplaceAction(this.routeName, {this.arguments});

  @override
  String toString() {
    return 'NavigateReplaceAction{routeName: $routeName}';
  }
}

class NavigatePushAction {
  final String routeName;
  final Object arguments;

  NavigatePushAction(this.routeName, {this.arguments});

  @override
  String toString() {
    return 'NavigatePushAction{routeName: $routeName}';
  }
}

class NavigatePopAction {
  @override
  String toString() {
    return 'NavigatePopAction';
  }
}
