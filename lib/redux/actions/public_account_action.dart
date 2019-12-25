import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/account_title_bean.dart';
import 'package:flutter_wanandroid_redux/data/base_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/public_account_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestAccountTitle() {
  return (Store<AppState> store) async {
    AccountTitleBean bean =
        await WanAndroidApi.getInstance().requestAccountTitle();
    if (bean.errorCode == 0) {
      List<AccountTitleData> dataList = bean.data;
      Map<int, PublicAccountItemState> accountMap =
          store.state.publicAccountState.accountMap;
      accountMap.clear();
      for (var titleData in dataList) {
        accountMap[titleData.id] = PublicAccountItemState.initial();
      }
      store.dispatch(
          UpdateAccountTitleAction(dataList: dataList, accountMap: accountMap));
    }
  };
}

ThunkAction<AppState> requestAccountData(int titleId, bool isRefresh) {
  return (Store<AppState> store) async {
    try {
      PublicAccountItemState state =
          store.state.publicAccountState.accountMap[titleId];
      int currentPage = isRefresh ? 1 : state.currentPage + 1;
      store.dispatch(
          UpdateItemIndexAction(titleId: titleId, currentPage: currentPage));

      HomeArticleBean bean = await WanAndroidApi.getInstance()
          .requestAccountList(titleId, currentPage);
      if (bean.errorCode == 0) {
        HomeArticleData articleData = bean.data;
        List<HomeArticle> dataList = bean.data.datas;
        if ((dataList == null || dataList.isEmpty) && isRefresh) {
          store.dispatch(UpdateItemLoadingStatusAction(
              titleId: titleId, status: LoadingStatus.error));
          return;
        }
        List<HomeArticle> articleList = state.articleList;
        if (isRefresh) articleList.clear();
        articleList.addAll(dataList);
        bool hasMoreData = articleList.length < articleData.total;
        store.dispatch(UpdateItemListAction(
            titleId: titleId,
            hasMoreData: hasMoreData,
            articleList: articleList));
      } else {
        if (isRefresh) {
          store.dispatch(UpdateItemLoadingStatusAction(
              titleId: titleId, status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: bean.errorMsg);
        }
      }
    } catch (e) {
      print(e);
      if (isRefresh) {
        store.dispatch(UpdateItemLoadingStatusAction(
            titleId: titleId, status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

ThunkAction<AppState> collectAccountArticle(
    int titleId, int articleId, int articleIndex, bool isCollect) {
  return (Store<AppState> store) async {
    BaseData data =
        await WanAndroidApi.getInstance().collectArticle(articleId, isCollect);
    if (data != null && data.errorCode == 0) {
      PublicAccountItemState state =
          store.state.publicAccountState.accountMap[titleId];
      List<HomeArticle> articleList = state.articleList;
      if (articleIndex >= 0 && articleIndex < articleList.length) {
        articleList[articleIndex].collect = isCollect;
        store.dispatch(UpdateCollectAction(titleId: titleId));
        String message = isCollect ? "收藏成功" : "取消收藏成功";
        Fluttertoast.showToast(msg: message);
      }
    } else {
      Fluttertoast.showToast(msg: data.errorMsg);
    }
  };
}

class UpdateAccountTitleAction {
  final List<AccountTitleData> dataList;
  final Map<int, PublicAccountItemState> accountMap;
  UpdateAccountTitleAction(
      {@required this.dataList, @required this.accountMap});
}

class UpdateItemIndexAction {
  final int titleId;
  final int currentPage;
  UpdateItemIndexAction({@required this.titleId, @required this.currentPage});
}

class UpdateItemLoadingStatusAction {
  final int titleId;
  final LoadingStatus status;
  UpdateItemLoadingStatusAction(
      {@required this.titleId, @required this.status});
}

class UpdateItemListAction {
  final int titleId;
  final bool hasMoreData;
  final List<HomeArticle> articleList;

  UpdateItemListAction(
      {@required this.titleId,
      @required this.hasMoreData,
      @required this.articleList});
}

class UpdateCollectAction {
  final int titleId;
  UpdateCollectAction({@required this.titleId});
}
