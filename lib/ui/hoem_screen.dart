import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String titleText;

  HomeScreen({this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(color: Colors.black, fontSize: 35.0),
          ),
        ),
      ),
    );
  }
}
