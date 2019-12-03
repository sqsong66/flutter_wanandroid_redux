import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/model/login_view_mode.dart';
import 'package:flutter_wanandroid_redux/ui/register_screen.dart';
import 'package:flutter_wanandroid_redux/widget/bottom_line_click_text_widget.dart';
import 'package:flutter_wanandroid_redux/widget/click_text_widget.dart';
import 'package:flutter_wanandroid_redux/widget/rounded_button_widget.dart';
import 'package:flutter_wanandroid_redux/widget/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  LoginWidget(this.viewModel);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isButtonEnable = false;
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _accountController.addListener(_textChangeListener);
    _passwordController.addListener(_textChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _textChangeListener() {
    setState(() {
      _isButtonEnable = _accountController.text.length > 0 &&
          _passwordController.text.length >= 6;
    });
  }

  void _startLoginRequest() {
    widget.viewModel.login(_accountController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Login",
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
                )
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            alignment: Alignment.centerRight,
            child: ClickTextWidget(
              text: "Forget Password?",
              clickCallback: () {
                Fluttertoast.showToast(msg: 'Developing...');
              },
            ),
          ),
          SizedBox(height: 60.0),
          RoundedButtonWidget(
            text: "Login",
            clickCallback: _startLoginRequest,
            isEnable: _isButtonEnable,
          ),
          SizedBox(height: 20.0),
          BottomLineClickTextWidget(
            text: "Not account yet? Create one.",
            clickCallback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
