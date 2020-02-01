import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const TextIconWidget({Key key, @required this.text, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 20,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
