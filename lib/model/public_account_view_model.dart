import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/account_title_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/public_account_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/public_account_state.dart';
import 'package:redux/redux.dart';

class PublicAccountViewModel {
  final List<AccountTitleData> accountTitles;
  final Map<int, PublicAccountItemState> accountMap;
  final Function(int, bool) loadArticleEvent;
  final Function(int, int, int, bool) collectArticle;

  PublicAccountViewModel(
      {@required this.accountTitles,
      @required this.accountMap,
      @required this.loadArticleEvent,
      @required this.collectArticle});

  static PublicAccountViewModel fromStore(Store<AppState> store) {
    return PublicAccountViewModel(
        accountTitles: store.state.publicAccountState.accountTitles,
        accountMap: store.state.publicAccountState.accountMap,
        loadArticleEvent: (titleId, isRefresh) {
          store.dispatch(requestAccountData(titleId, isRefresh));
        },
        collectArticle:
            (int titleId, int articleId, int articleIndex, bool isCollect) {
          store.dispatch(collectAccountArticle(
              titleId, articleId, articleIndex, isCollect));
        });
  }
}
