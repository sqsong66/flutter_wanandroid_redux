import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> searchArticles(bool isRefresh) {
  return (Store<AppState> store) async {
    try {
      int currentPage =
          isRefresh ? 0 : store.state.searchResultSate.currentPage + 1;
      store.dispatch(UpdatePageIndexAction(currentPage: currentPage));
      String keyWord = store.state.searchResultSate.queryText;
      await CommonUtils.saveSearchKeyWord(keyWord);
      HomeArticleBean bean = await WanAndroidApi.getInstance()
          .searchArticles(keyWord, currentPage);
      if (bean.errorCode == 0 && bean.data != null) {
        List<HomeArticle> articleList = store.state.searchResultSate.articleList;
        var dataList = bean.data.datas;
        if (isRefresh && (dataList == null || dataList.isEmpty)) {
          store
              .dispatch(UpdateLoadingStatusAction(status: LoadingStatus.empty));
          return;
        }

        if (isRefresh) articleList.clear();
        articleList.addAll(dataList);
        bool hasMoreData = articleList.length < bean.data.total;
        store.dispatch(UpdateArticlesAction(
            hasMoreData: hasMoreData,
            articleResult: bean.data.total,
            articleList: articleList));
      } else {
        if (isRefresh) {
          store
              .dispatch(UpdateLoadingStatusAction(status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: bean.errorMsg);
        }
      }
    } catch (e) {
      print(e);
      if (isRefresh) {
        store.dispatch(UpdateLoadingStatusAction(status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

class UpdateQueryTextAction {
  final String queryText;
  UpdateQueryTextAction({@required this.queryText});
}

class UpdatePageIndexAction {
  final int currentPage;
  UpdatePageIndexAction({@required this.currentPage});
}

class UpdateLoadingStatusAction {
  final LoadingStatus status;
  UpdateLoadingStatusAction({@required this.status});
}

class UpdateArticlesAction {
  final bool hasMoreData;
  final int articleResult;
  final List<HomeArticle> articleList;
  UpdateArticlesAction(
      {@required this.hasMoreData,
      @required this.articleResult,
      @required this.articleList});
}

class ClearResultAction {
  ClearResultAction();
}
