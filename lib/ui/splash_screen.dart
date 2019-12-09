import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/datas.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/ui/main_screen.dart';
import 'package:flutter_wanandroid_redux/widget/countdown_widget.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageList[Random().nextInt(12)],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 20.0,
              bottom: 30.0,
              child: CountdownWidget(
                onCountdownTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      List<Cookie> cookieList =
                          WanAndroidApi.getInstance().loadCookies();
                      if (cookieList == null || cookieList.isEmpty) {
                        return LoginScreen();
                      } else {
                        return MainScreen();
                      }
                    }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
