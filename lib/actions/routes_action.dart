class NavigateReplaceAction {
  final String routeName;
  final Object arguments;

  NavigateReplaceAction(this.routeName, {this.arguments});
}

class NavigatePushAction {
  final String routeName;
  final Object arguments;

  NavigatePushAction(this.routeName, {this.arguments});
}

class NavigatePopAction {}
