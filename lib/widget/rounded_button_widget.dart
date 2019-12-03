import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String text;
  final bool isEnable;
  final VoidCallback clickCallback;

  RoundedButtonWidget(
      {@required this.text,
      @required this.clickCallback,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        disabledColor: Colors.grey[400],
        textColor: Colors.white,
        disabledTextColor: Colors.white54,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: isEnable ? clickCallback : null,
      ),
    );
  }
}
