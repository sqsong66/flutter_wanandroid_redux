import 'package:flutter/material.dart';

class PasswordStateWidget extends StatefulWidget {
  final double iconSize;
  final Function(bool) onVisibilityChanged;

  PasswordStateWidget({this.iconSize = 25.0, this.onVisibilityChanged});

  @override
  _PasswordStateWidgetState createState() => _PasswordStateWidgetState();
}

class _PasswordStateWidgetState extends State<PasswordStateWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: () {
          isVisible = !isVisible;
          widget.onVisibilityChanged(isVisible);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            size: widget.iconSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
