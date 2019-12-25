import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/account_title_bean.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';

@immutable
class PublicAccountState {
  final List<AccountTitleData> accountTitles;
  final Map<int, PublicAccountItemState> accountMap;

  PublicAccountState({@required this.accountTitles, @required this.accountMap});

  factory PublicAccountState.initial() {
    return PublicAccountState(accountTitles: [], accountMap: LinkedHashMap());
  }

  PublicAccountState copyWith(List<AccountTitleData> accountTitles,
      Map<int, PublicAccountItemState> accountMap) {
    return PublicAccountState(
        accountTitles: accountTitles ?? this.accountTitles,
        accountMap: accountMap ?? this.accountMap);
  }
}

@immutable
class PublicAccountItemState {
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<HomeArticle> articleList;

  PublicAccountItemState(
      {@required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.articleList});

  factory PublicAccountItemState.initial() {
    return PublicAccountItemState(
        currentPage: 1,
        isLoading: false,
        hasMoreData: true,
        status: LoadingStatus.idle,
        articleList: []);
  }

  PublicAccountItemState copyWith(int currentPage, bool isLoading,
      bool hasMoreData, LoadingStatus status, List<HomeArticle> articleList) {
    return PublicAccountItemState(
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        articleList: articleList ?? this.articleList);
  }
}
