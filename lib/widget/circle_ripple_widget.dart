import 'package:flutter/material.dart';

class CircleRippleWidget extends StatelessWidget {
  final Icon icon;
  final Function onClick;

  CircleRippleWidget({@required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ),
    );
  }
}
