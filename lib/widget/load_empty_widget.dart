import 'package:flutter/material.dart';

class LoadEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).cardColor),
            child: Icon(Icons.warning, size: 50.0, color: Colors.white60),
          ),
          SizedBox(height: 16.0),
          Text("There is nothing.",
              style: TextStyle(fontSize: 16.0, color: Colors.white60))
        ],
      ),
    );
  }
}
