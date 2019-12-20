import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

@immutable
class SearchResultViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<HomeArticle> articleList;

  SearchResultViewModel({
    @required this.isLoading,
    @required this.hasMoreData,
    @required this.status,
    @required this.articleList,
  });

  static SearchResultViewModel fromStore(Store<AppState> store) {
    return SearchResultViewModel(
        isLoading: store.state.searchResultSate.isLoading,
        hasMoreData: store.state.searchResultSate.hasMoreData,
        status: store.state.searchResultSate.status,
        articleList: store.state.searchResultSate.articleList);
  }
}
