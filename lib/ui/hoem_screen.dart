import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/widget/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  final String titleText;

  HomeScreen({this.titleText});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<BannerData> bannerList = [
      BannerData(imagePath: "assets/images/image01.jpg"),
      BannerData(imagePath: "assets/images/image02.jpg"),
      BannerData(imagePath: "assets/images/image03.jpg"),
      BannerData(imagePath: "assets/images/image04.jpg"),
    ];
    return Column(
      children: <Widget>[
        BannerWidget(bannerLists: bannerList,)
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
