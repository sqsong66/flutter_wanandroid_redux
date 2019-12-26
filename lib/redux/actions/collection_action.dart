import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/base_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestCollectionData(bool isRefresh) {
  return (Store<AppState> store) async {
    int currentPage =
        isRefresh ? 0 : store.state.collectionState.currentPage + 1;
    store.dispatch(UpdateCollectionIndexAction(currentPage: currentPage));
    try {
      HomeArticleBean bean =
          await WanAndroidApi.getInstance().requestCollections(currentPage);
      if (bean.errorCode == 0) {
        List<HomeArticle> articleList = store.state.collectionState.articleList;
        if (isRefresh) articleList.clear();
        List<HomeArticle> dataList = bean.data.datas;
        if (isRefresh && (dataList == null || dataList.isEmpty)) {
          store
              .dispatch(UpdateCollectStatusAction(status: LoadingStatus.empty));
          return;
        }
        articleList.addAll(dataList);
        store.dispatch(UpdateCollectDataAction(
            hasMoreData: articleList.length < bean.data.total,
            articleList: articleList));
      } else {
        if (isRefresh) {
          store
              .dispatch(UpdateCollectStatusAction(status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: bean.errorMsg);
        }
      }
    } catch (e) {
      print(e);
      if (isRefresh) {
        store.dispatch(UpdateCollectStatusAction(status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

ThunkAction<AppState> removeCollectArticle(int articleId, int articleIndex) {
  return (Store<AppState> store) async {
    BaseData bean =
        await WanAndroidApi.getInstance().collectArticle(articleId, false);
    if (bean.errorCode == 0) {
      List<HomeArticle> articleList = store.state.collectionState.articleList;
      if (articleIndex >= 0 && articleIndex < articleList.length) {
        articleList.removeAt(articleIndex);
        store.dispatch(UpdateCollectDataAction(
            hasMoreData: store.state.collectionState.hasMoreData,
            articleList: articleList));
        Fluttertoast.showToast(msg: "取消收藏成功");
      }
    } else {
      Fluttertoast.showToast(msg: bean.errorMsg);
    }
  };
}

class UpdateCollectionIndexAction {
  final int currentPage;
  UpdateCollectionIndexAction({@required this.currentPage});
}

class UpdateCollectStatusAction {
  final LoadingStatus status;
  UpdateCollectStatusAction({@required this.status});
}

class UpdateCollectDataAction {
  final bool hasMoreData;
  final List<HomeArticle> articleList;
  UpdateCollectDataAction(
      {@required this.hasMoreData, @required this.articleList});
}
