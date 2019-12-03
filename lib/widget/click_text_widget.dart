import 'package:flutter/material.dart';

class ClickTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback clickCallback;

  ClickTextWidget({@required this.text, @required this.clickCallback});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: clickCallback,
      splashColor: Colors.white30,
      highlightColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
