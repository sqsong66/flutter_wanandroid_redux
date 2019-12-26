import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:meta/meta.dart';

@immutable
class CollectionState {
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<HomeArticle> articleList;

  CollectionState(
      {@required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.articleList});

  factory CollectionState.initial() {
    return CollectionState(
        currentPage: 0,
        isLoading: false,
        hasMoreData: true,
        status: LoadingStatus.idle,
        articleList: []);
  }

  CollectionState copyWith(int currentPage, bool isLoading, bool hasMoreData,
      LoadingStatus status, List<HomeArticle> articleList) {
    return CollectionState(
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        articleList: articleList ?? this.articleList);
  }
}
