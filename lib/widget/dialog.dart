import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, String loadingText) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Color(0xAA000000),
          elevation: 0.0,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
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
