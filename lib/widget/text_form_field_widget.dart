import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/widget/password_state_widget.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;

  TextFormFieldWidget(this.hintText, this.labelText, this.isPassword,
      {this.controller});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? PasswordStateWidget(iconSize: 25.0,
                onVisibilityChanged: (isVisible) {
                  setState(() {
                    _isVisible = isVisible;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white70),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 16.0),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal[400]),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 18.0),
      keyboardType: TextInputType.text,
      obscureText: widget.isPassword && !_isVisible,
      controller: widget.controller,
    );
  }
}
