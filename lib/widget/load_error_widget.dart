import 'package:flutter/material.dart';

class LoadErrorWidget extends StatelessWidget {
  final Function onRetry;

  LoadErrorWidget({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 80.0,
          ),
          Text("Oops!",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text("Something wrong~", style: TextStyle(fontSize: 14.0)),
          SizedBox(height: 32.0),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
            child: Text(
              "Retry",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            splashColor: Colors.black26,
            color: Theme.of(context).accentColor,
            onPressed: () {
              onRetry();
            },
          )
        ],
      ),
    );
  }
}
