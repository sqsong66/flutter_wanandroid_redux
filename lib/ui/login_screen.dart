import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/datas.dart';
import 'package:flutter_wanandroid_redux/model/login_view_mode.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/main_screen.dart';
import 'package:flutter_wanandroid_redux/widget/blur_image_widget.dart';
import 'package:flutter_wanandroid_redux/widget/close_widget.dart';
import 'package:flutter_wanandroid_redux/widget/dialog.dart';
import 'package:flutter_wanandroid_redux/widget/login_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDialogShowing = false;
  int _imageIndex = Random().nextInt(12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: <Widget>[
            BlurImageWidget(
              assetImageUrl: imageList[_imageIndex],
            ),
            Positioned(
              left: 30.0,
              top: 55.0,
              child: CloseWidget(onClick: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }),
            ),
            Center(
                child: StoreConnector<AppState, LoginViewModel>(
              converter: (store) => LoginViewModel.fromStore(store),
              builder: (context, viewModel) => LoginWidget(viewModel),
              onDidChange: (viewModel) {
                if (viewModel.isLoading) {
                  showLoadingDialog(context, "Logining...");
                  _isDialogShowing = true;
                } else {
                  if (_isDialogShowing) {
                    Navigator.of(context).pop();
                  }
                }

                if (viewModel.loginStatus == 1) {
                  // Login success.
                  Fluttertoast.showToast(msg: "Login Success.");
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                }
                if (viewModel.loginStatus == 2) {
                  // Login error.
                  Fluttertoast.showToast(msg: viewModel.errorMessage);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
