import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/datas.dart';
import 'package:flutter_wanandroid_redux/ui/login_screen.dart';
import 'package:flutter_wanandroid_redux/widget/countdown_widget.dart';

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
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(), // MainScreen(),
                    ),
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
