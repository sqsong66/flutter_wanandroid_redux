import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/actions/search_result_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

@immutable
class SearchResultViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final int articleResult;
  final LoadingStatus status;
  final List<HomeArticle> articleList;
  final Function(int articleId, int articleIndex, bool isCollect)
      collectArticle;
  final Function loadMore;
  final Function(String) startSearch;
  final Function clearResult;

  SearchResultViewModel({
    @required this.isLoading,
    @required this.hasMoreData,
    @required this.articleResult,
    @required this.status,
    @required this.articleList,
    @required this.collectArticle,
    @required this.loadMore,
    @required this.startSearch,
    @required this.clearResult,
  });

  static SearchResultViewModel fromStore(Store<AppState> store) {
    return SearchResultViewModel(
        isLoading: store.state.searchResultSate.isLoading,
        hasMoreData: store.state.searchResultSate.hasMoreData,
        status: store.state.searchResultSate.status,
        articleResult: store.state.searchResultSate.articleResult,
        articleList: store.state.searchResultSate.articleList,
        collectArticle: (articleId, articleIndex, isCollect) {
          store.dispatch(
              collectArticleAction(articleId, articleIndex, isCollect, 2));
        },
        loadMore: () {
          store.dispatch(searchArticles(false));
        },
        startSearch: (queryText) {
          store.dispatch(UpdateQueryTextAction(queryText: queryText));
          store.dispatch(searchArticles(true));
        },
        clearResult: () {
          store.dispatch(ClearResultAction());
        });
  }
}
