import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/widget/rounded_button_widget.dart';
import 'package:flutter_wanandroid_redux/widget/text_form_field_widget.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Register",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 60.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          Form(
            child: Column(
              children: <Widget>[
                TextFormFieldWidget("User Name", "Enter your name", false),
                SizedBox(height: 20.0),
                TextFormFieldWidget("Password", "Enter your password", true),
                SizedBox(height: 20.0),
                TextFormFieldWidget("Confirm Password", "Enter your password again", true)
              ],
            ),
          ),
          SizedBox(height: 60.0),
          RoundedButtonWidget(
            text: "Register",
            clickCallback: () {},
          ),
        ],
      ),
    );
  }
}
