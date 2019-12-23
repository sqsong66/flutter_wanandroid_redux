import 'package:flutter/material.dart';

import 'circle_ripple_widget.dart';

class CommonToolbarWidget extends StatelessWidget {
  final String title;

  CommonToolbarWidget(this.title);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: kToolbarHeight + topPadding,
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        children: <Widget>[
          SizedBox(width: 16),
          CircleRippleWidget(
            icon: Icon(Icons.arrow_back, size: 24.0),
            onClick: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 16),
          Text(title,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                decoration: TextDecoration.none,
              ))
        ],
      ),
    );
  }
}
