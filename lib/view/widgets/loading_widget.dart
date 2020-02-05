import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final bool cancelable;
  final Widget child;
  LoadingWidget({
    @required this.isLoading,
    this.cancelable = false,
    @required this.child,
  })  : assert(child != null),
        assert(cancelable != null);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isLoading) {
      final modal = [
        Opacity(
          opacity: 0.2,
          child: ModalBarrier(
            dismissible: cancelable,
            color: Colors.grey,
          ),
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ];
      widgetList += modal;
    }
    return Stack(children: widgetList);
  }
}
