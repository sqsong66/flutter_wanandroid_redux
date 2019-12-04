import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:meta/meta.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final LoadingStatus status;
  final List<BannerData> bannerList;
  final List<HomeArticle> articleList;

  HomeViewModel(
      {this.status = LoadingStatus.idle,
      @required this.bannerList,
      @required this.articleList});

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
        status: store.state.homeState.status,
        bannerList: store.state.homeState.bannerList,
        articleList: store.state.homeState.articleList);
  }
}
