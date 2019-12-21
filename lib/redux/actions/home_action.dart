import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/base_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> refreshBannerDataAction(BuildContext context) {
  return (Store<AppState> store) async {
    List<BannerData> bannerList =
        await WanAndroidApi.getInstance().getBannerList();
    double bannerHeight = 0;
    if (bannerList == null) {
      bannerList = [];
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      ui.Image image = await _getImage(bannerList[0].imagePath);
      bannerHeight =
          (screenWidth - 2 * 10.0) * image.height / image.width + 16.0;
    }
    store.dispatch(HomeBannerUpdatedAction(
        bannerList: bannerList, bannerHeight: bannerHeight));
  };
}

Future<ui.Image> _getImage(String url) async {
  Completer<ui.Image> completer = Completer();
  NetworkImage(url).resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image)));
  return completer.future;
}

ThunkAction<AppState> loadHomeArticleAction(bool isRefresh) {
  return (Store<AppState> store) async {
    try {
      int currentPage = isRefresh ? 0 : store.state.homeState.currentPage + 1;
      store.dispatch(RefreshHomeArticleAction(
        currentPage: currentPage,
      ));
      HomeArticleBean bean =
          await WanAndroidApi.getInstance().getHomeArticles(currentPage);
      if (bean.errorCode == 0 && bean.data != null) {
        List<HomeArticle> articleList = store.state.homeState.articleList;
        if (isRefresh) articleList.clear();
        articleList.addAll(bean.data.datas);
        bool hasMoreData = articleList.length < bean.data.total;
        store.dispatch(HomeArticleUpdateAction(
            hasMoreData: hasMoreData, articleList: articleList));
        store.dispatch(LoadStatusAction(status: LoadingStatus.success));
      } else {
        if (isRefresh) {
          store.dispatch(LoadStatusAction(status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: bean.errorMsg);
        }
      }
    } catch (e) {
      print(e.toString());
      if (isRefresh) {
        store.dispatch(LoadStatusAction(status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

ThunkAction<AppState> collectArticleAction(
    int articleId, int articleIndex, bool isCollect, int type) { // type: 0 - home article  1 - project article  2 - search article
  return (Store<AppState> store) async {
    BaseData data =
        await WanAndroidApi.getInstance().collectArticle(articleId, isCollect);
    if (data != null && data.errorCode == 0) {
      List<HomeArticle> articleList;
      if (type == 0) {
        articleList = store.state.homeState.articleList;
      } else if (type == 1) {
        articleList = store.state.projectState.projectList;
      } else {
        articleList = store.state.searchResultSate.articleList;
      }
      if (articleIndex >= 0 && articleIndex < articleList.length) {
        articleList[articleIndex].collect = isCollect;
        store.dispatch(CollectArticleAction());
        String message = isCollect ? "收藏成功" : "取消收藏成功";
        Fluttertoast.showToast(msg: message);
      }
    } else {
      Fluttertoast.showToast(msg: data.errorMsg);
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
  final bool hasMoreData;
  final List<HomeArticle> articleList;
  HomeArticleUpdateAction({this.hasMoreData, this.articleList});
}

class RefreshHomeArticleAction {
  final int currentPage;
  RefreshHomeArticleAction({this.currentPage});
}

class CollectArticleAction {
  CollectArticleAction();
}

class LoadStatusAction {
  final LoadingStatus status;
  LoadStatusAction({this.status});
}
