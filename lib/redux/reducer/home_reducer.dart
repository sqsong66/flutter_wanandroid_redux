import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, HomeBannerUpdatedAction>(_refreshBanner),
  TypedReducer<HomeState, RefreshHomeArticleAction>(_refreshArticle),
  TypedReducer<HomeState, HomeArticleUpdateAction>(_articleUpdate),
]);

HomeState _refreshBanner(HomeState state, HomeBannerUpdatedAction action) {
  return state.copyWith(state.currentPage, state.isLoading, state.hasMoreData, state.status,
      action.bannerHeight, action.bannerList, state.articleList);
}

HomeState _refreshArticle(HomeState state, RefreshHomeArticleAction action) {
  return state.copyWith(action.currentPage, true, state.hasMoreData, state.status,
      state.bannerHeight, state.bannerList, state.articleList);
}

HomeState _articleUpdate(HomeState state, HomeArticleUpdateAction action) {
  return state.copyWith(state.currentPage, false, action.hasMoreData, state.status,
      state.bannerHeight, state.bannerList, action.articleList);
}


