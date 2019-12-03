import 'package:flutter/material.dart';

class BottomLineClickTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback clickCallback;

  BottomLineClickTextWidget({@required this.text, @required this.clickCallback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: clickCallback,
        splashColor: Colors.white30,
        highlightColor: Colors.black12,
        borderRadius: BorderRadius.circular(5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Container(
            padding: EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
