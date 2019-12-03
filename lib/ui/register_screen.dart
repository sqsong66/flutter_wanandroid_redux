import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/datas.dart';
import 'package:flutter_wanandroid_redux/widget/blur_image_widget.dart';
import 'package:flutter_wanandroid_redux/widget/close_widget.dart';
import 'package:flutter_wanandroid_redux/widget/register_widget.dart';

/// 注册页面
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                Navigator.pop(context);
              }),
            ),
            Center(child: RegisterWidget())
          ],
        ),
      ),
    );
  }
}
