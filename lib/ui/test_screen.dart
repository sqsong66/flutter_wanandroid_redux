import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final String titleText;

  TestScreen({this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(color: Colors.white, fontSize: 35.0),
          ),
        ),
      ),
    );
  }
}
