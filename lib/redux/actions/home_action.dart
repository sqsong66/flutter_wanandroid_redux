import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction refreshBannerData(BuildContext context) {
  return (Store store) async {
    List<BannerData> bannerList = await WanAndroidApi().getBannerList();
    double bannerHeight = 0;
    if (bannerList == null) {
      bannerList = [];
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      ui.Image image = await _getImage(bannerList[0].imagePath);
      bannerHeight =
          (screenWidth - 2 * 10.0) * image.height / image.width + 16.0;
    }
    store.dispatch(
        HomeBannerUpdatedAction(bannerList: bannerList, bannerHeight: bannerHeight));
  };
}

Future<ui.Image> _getImage(String url) async {
  Completer<ui.Image> completer = Completer();
  NetworkImage(url).resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image)));
  return completer.future;
}

ThunkAction loadHomeArticle() {
  return (Store store) async {
    try {
      HomeArticleBean bean = await WanAndroidApi().getHomeArticles(0);
      if (bean.errorCode == 0 && bean.data != null) {
        List<HomeArticle> articleList = bean.data.datas;
        store.dispatch(HomeArticleUpdateAction(articleList: articleList));
      }
    } catch (e) {
      print(e.toString());
    }
  };
}

class RefreshHomeBannerAction {
  RefreshHomeBannerAction();
}

class HomeBannerUpdatedAction {
  final double bannerHeight;
  final List<BannerData> bannerList;
  HomeBannerUpdatedAction({this.bannerList, this.bannerHeight});
}

class HomeArticleUpdateAction {
  List<HomeArticle> articleList;
  HomeArticleUpdateAction({this.articleList});
}

class RefreshHomeArticleAction {
  final int currentPage;
  RefreshHomeArticleAction({this.currentPage});
}
