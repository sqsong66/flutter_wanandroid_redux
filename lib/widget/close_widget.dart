import 'package:flutter/material.dart';

class CloseWidget extends StatelessWidget {

  final Function onClick;

  CloseWidget({this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.close,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
