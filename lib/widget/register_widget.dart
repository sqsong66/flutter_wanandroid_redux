import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/widget/rounded_button_widget.dart';
import 'package:flutter_wanandroid_redux/widget/text_form_field_widget.dart';

class RegisterWidget extends StatefulWidget {
  final Function(String, String, String) startRegister;

  const RegisterWidget({Key key, @required this.startRegister})
      : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool _isButtonEnable = false;
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _accountController.addListener(_textChangeListener);
    _passwordController.addListener(_textChangeListener);
    _confirmPasswordController.addListener(_textChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _textChangeListener() {
    setState(() {
      _isButtonEnable = _accountController.text.length > 0 &&
          _passwordController.text.length >= 6 &&
          _confirmPasswordController.text.length >= 6 &&
          (_passwordController.text == _confirmPasswordController.text);
    });
  }

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
                TextFormFieldWidget(
                  "User Name",
                  "Enter your name",
                  false,
                  controller: _accountController,
                ),
                SizedBox(height: 20.0),
                TextFormFieldWidget(
                  "Password",
                  "Enter your password",
                  true,
                  controller: _passwordController,
                ),
                SizedBox(height: 20.0),
                TextFormFieldWidget(
                  "Confirm Password",
                  "Enter your password again",
                  true,
                  controller: _confirmPasswordController,
                )
              ],
            ),
          ),
          SizedBox(height: 60.0),
          RoundedButtonWidget(
            text: "Register",
            isEnable: _isButtonEnable,
            clickCallback: () {
              widget.startRegister(_accountController.text,
                  _passwordController.text, _confirmPasswordController.text);
            },
          ),
        ],
      ),
    );
  }
}
