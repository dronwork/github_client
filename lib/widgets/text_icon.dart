import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;

  const TextIcon({Key key, @required this.text, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}
