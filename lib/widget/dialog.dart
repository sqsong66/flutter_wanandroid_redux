import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, String loadingText) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          elevation: 0.0,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  loadingText,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ],
        );
      });
}
