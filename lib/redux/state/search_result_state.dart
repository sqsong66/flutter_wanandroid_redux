import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';

@immutable
class SearchResultSate {
  final String queryText;
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<HomeArticle> articleList;

  SearchResultSate(
      {@required this.queryText,
      @required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.articleList});

  factory SearchResultSate.initial() {
    return SearchResultSate(
        queryText: "",
        currentPage: 0,
        isLoading: false,
        hasMoreData: true,
        status: LoadingStatus.idle,
        articleList: []);
  }

  SearchResultSate copyWith(String queryText, int currentPage, bool isLoading,
      bool hasMoreData, LoadingStatus status, List<HomeArticle> articleList) {
    return SearchResultSate(
        queryText: queryText ?? this.queryText,
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        articleList: articleList ?? this.articleList);
  }
}
