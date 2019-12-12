import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
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
          SettingItemWidget(icon: FontAwesomeIcons.bookmark, title: "Collections"),
          SizedBox(height: 1.0),
          SettingItemWidget(icon: FontAwesomeIcons.compass, title: "Navigation"),
          SizedBox(height: 1.0),
          SettingItemWidget(icon: FontAwesomeIcons.weixin, title: "Public Account"),
          SizedBox(height: 1.0),
          SettingItemWidget(icon: FontAwesomeIcons.gift, title: "Welfare"),
          SizedBox(height: 1.0),
          SettingItemWidget(icon: FontAwesomeIcons.signOutAlt, title: "Login Out", onClick: (){
            WanAndroidApi.getInstance().clearCookies();
          },),
        ],
      ),
    );
  }
}
