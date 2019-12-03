import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/widget/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  final String titleText;

  HomeScreen({this.titleText});

  @override
  Widget build(BuildContext context) {

    List<BannerData> bannerList = [
      BannerData(imagePath: "assets/images/image01.jpg"),
      BannerData(imagePath: "assets/images/image02.jpg"),
      BannerData(imagePath: "assets/images/image03.jpg"),
      BannerData(imagePath: "assets/images/image04.jpg"),
    ];
    return Column(
      children: <Widget>[
        BannerWidget(imageLists: bannerList,)
      ],
    );
  }
}
