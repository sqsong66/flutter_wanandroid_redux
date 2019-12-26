import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/collection_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

@immutable
class CollectionViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<HomeArticle> articleList;
  final Function(bool) loadArticles;
  final Function(int, int) removeCollectionArticle;

  CollectionViewModel(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.articleList,
      @required this.loadArticles,
      @required this.removeCollectionArticle});

  static CollectionViewModel fromStore(Store<AppState> store) {
    return CollectionViewModel(
        isLoading: store.state.collectionState.isLoading,
        hasMoreData: store.state.collectionState.hasMoreData,
        status: store.state.collectionState.status,
        articleList: store.state.collectionState.articleList,
        loadArticles: (isRefresh) {
          store.dispatch(requestCollectionData(isRefresh));
        },
        removeCollectionArticle: (articleId, articleIndex) {
          store.dispatch(removeCollectArticle(articleId, articleIndex));
        });
  }
}
