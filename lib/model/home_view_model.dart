import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final double bannerHeight;
  final List<BannerData> bannerList;
  final List<HomeArticle> articleList;
  final Function(BuildContext context, bool isLoadMoreArticle) refreshEvents;

  HomeViewModel(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.bannerHeight,
      @required this.bannerList,
      @required this.articleList,
      @required this.refreshEvents});

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
        isLoading: store.state.homeState.isLoading,
        hasMoreData: store.state.homeState.hasMoreData,
        status: store.state.homeState.status,
        bannerHeight: store.state.homeState.bannerHeight,
        bannerList: store.state.homeState.bannerList,
        articleList: store.state.homeState.articleList,
        refreshEvents: (context, isRefresh) {
          if (isRefresh) {
            store.dispatch(refreshBannerData(context));
          }
          store.dispatch(loadHomeArticle(isRefresh));
        });
  }
}
