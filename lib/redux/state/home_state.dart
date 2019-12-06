import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:meta/meta.dart';

enum LoadingStatus {
  idle,
  loading,
  error,
  success,
}

@immutable
class HomeState {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final double bannerHeight;
  final List<BannerData> bannerList;
  final List<HomeArticle> articleList;

  HomeState(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.bannerHeight,
      @required this.bannerList,
      @required this.articleList});

  factory HomeState.initial() {
    return HomeState(
        isLoading: true,
        hasMoreData: true,
        status: LoadingStatus.idle,
        bannerHeight: 0,
        bannerList: [],
        articleList: []);
  }

  HomeState copyWith(
      bool isLoading,
      bool hasMoreData,
      LoadingStatus status,
      double bannerHeight,
      List<BannerData> bannerList,
      List<HomeArticle> articleList) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        bannerHeight: bannerHeight ?? this.bannerHeight,
        bannerList: bannerList ?? this.bannerList,
        articleList: articleList ?? this.articleList);
  }
}
