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
  final LoadingStatus status;
  final List<BannerData> bannerList;
  final List<HomeArticle> articleList;

  HomeState(
      {@required this.status,
      @required this.bannerList,
      @required this.articleList});

  factory HomeState.initial() {
    return HomeState(
        status: LoadingStatus.idle, bannerList: [], articleList: []);
  }

  HomeState copyWith(LoadingStatus status, List<BannerData> bannerList,
      List<HomeArticle> articleList) {
    return HomeState(
        status: status ?? this.status,
        bannerList: bannerList ?? this.bannerList,
        articleList: articleList ?? this.articleList);
  }
}
