import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
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
      HomeArticleBean bean = await WanAndroidApi.getInstance()
          .searchArticles(keyWord, currentPage);
      if (bean.errorCode == 0 && bean.data != null) {
        List<HomeArticle> articleList = store.state.homeState.articleList;
        if (isRefresh) articleList.clear();
        articleList.addAll(bean.data.datas);
        bool hasMoreData = articleList.length < bean.data.total;
        store.dispatch(UpdateArticlesAction(
            hasMoreData: hasMoreData, articleList: articleList));
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
  UpdateQueryTextAction({this.queryText});
}

class UpdatePageIndexAction {
  final int currentPage;
  UpdatePageIndexAction({this.currentPage});
}

class UpdateLoadingStatusAction {
  final LoadingStatus status;
  UpdateLoadingStatusAction({this.status});
}

class UpdateArticlesAction {
  final bool hasMoreData;
  final List<HomeArticle> articleList;
  UpdateArticlesAction({this.hasMoreData, this.articleList});
}
