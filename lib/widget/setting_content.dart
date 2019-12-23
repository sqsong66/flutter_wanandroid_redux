import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/ui/login_screen.dart';
import 'package:flutter_wanandroid_redux/ui/navigation_screen.dart';
import 'package:flutter_wanandroid_redux/ui/welfare_screen.dart';
import 'package:flutter_wanandroid_redux/widget/setting_item_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingContent extends StatelessWidget {
  final double contentHeight;
  SettingContent({this.contentHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: contentHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 65.0),
          SettingItemWidget(
              icon: FontAwesomeIcons.bookmark, title: "Collections"),
          Container(
              height: 1.0,
              color: Colors.white12,
              margin: EdgeInsets.only(left: 16)),
          SettingItemWidget(
              icon: FontAwesomeIcons.compass,
              title: "Navigation",
              onClick: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NavigationScreen()))),
          Container(
              height: 1.0,
              color: Colors.white12,
              margin: EdgeInsets.only(left: 16)),
          SettingItemWidget(
              icon: FontAwesomeIcons.weixin, title: "Public Account"),
          Container(
              height: 1.0,
              color: Colors.white12,
              margin: EdgeInsets.only(left: 16)),
          SettingItemWidget(
            icon: FontAwesomeIcons.gift,
            title: "Welfare",
            onClick: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => WelfareScreen())),
          ),
          Container(
              height: 1.0,
              color: Colors.white12,
              margin: EdgeInsets.only(left: 16)),
          SettingItemWidget(
            icon: FontAwesomeIcons.signOutAlt,
            title: "Login Out",
            onClick: () {
              if (WanAndroidApi.getInstance().isLogin()) {
                _showConfimLoginOutDialog(context);
              } else {
                _loginOut(context);
              }
            },
          ),
          Container(
              height: 1.0,
              color: Colors.white12,
              margin: EdgeInsets.only(left: 16)),
        ],
      ),
    );
  }

  void _showConfimLoginOutDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Tips", style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text("Confirm login out?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Confirm",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  _loginOut(context);
                },
              ),
            ],
          );
        });
  }

  void _loginOut(BuildContext context) {
    WanAndroidApi.getInstance().clearCookies();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}
