import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/datas.dart';
import 'package:flutter_wanandroid_redux/model/register_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/main_screen.dart';
import 'package:flutter_wanandroid_redux/widget/blur_image_widget.dart';
import 'package:flutter_wanandroid_redux/widget/close_widget.dart';
import 'package:flutter_wanandroid_redux/widget/dialog.dart';
import 'package:flutter_wanandroid_redux/widget/register_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

/// 注册页面
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _imageIndex = Random().nextInt(12);
  bool _isDialogShowing = false;
  bool _isRegisterSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: <Widget>[
            BlurImageWidget(assetImageUrl: imageList[_imageIndex]),
            Positioned(
              left: 30.0,
              top: 55.0,
              child: CloseWidget(onClick: () {
                Navigator.pop(context);
              }),
            ),
            Center(
                child: StoreConnector<AppState, RegisterViewModel>(
              distinct: false,
              converter: (Store store) => RegisterViewModel.fromStore(store),
              builder: (BuildContext context, RegisterViewModel viewModel) {
                return RegisterWidget(
                  startRegister: (account, password, confirmPassowrd) {
                    viewModel.register(account, password, confirmPassowrd);
                  },
                );
              },
              onDidChange: (viewModel) {
                if (viewModel.type != 1) return;
                if (viewModel.isLoading) {
                  showLoadingDialog(context, "Registering...");
                  _isDialogShowing = true;
                } else if (viewModel.registerStatus == 1 &&
                    !_isRegisterSuccess) {
                  _isRegisterSuccess = true;
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                } else if (viewModel.registerStatus == 2) {
                  if (_isDialogShowing) {
                    Navigator.of(context).pop();
                  }
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
