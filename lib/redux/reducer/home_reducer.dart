import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, HomeBannerUpdatedAction>(_refreshBanner),
  TypedReducer<HomeState, RefreshHomeArticleAction>(_refreshArticle),
  TypedReducer<HomeState, HomeArticleUpdateAction>(_articleUpdate),
  TypedReducer<HomeState, CollectArticleAction>(_collectUpdate),
  TypedReducer<HomeState, LoadStatusAction>(_loadingStatusUpdate),
]);

HomeState _refreshBanner(HomeState state, HomeBannerUpdatedAction action) {
  return state.copyWith(
      state.currentPage,
      state.isLoading,
      state.hasMoreData,
      state.status,
      action.bannerHeight,
      action.bannerList,
      state.articleList);
}

HomeState _refreshArticle(HomeState state, RefreshHomeArticleAction action) {
  return state.copyWith(
      action.currentPage,
      true,
      state.hasMoreData,
      state.status,
      state.bannerHeight,
      state.bannerList,
      state.articleList);
}

HomeState _articleUpdate(HomeState state, HomeArticleUpdateAction action) {
  return state.copyWith(
      state.currentPage,
      false,
      action.hasMoreData,
      state.status,
      state.bannerHeight,
      state.bannerList,
      action.articleList);
}

HomeState _collectUpdate(HomeState state, CollectArticleAction action) {
  return state.copyWith(
      state.currentPage,
      state.isLoading,
      state.hasMoreData,
      state.status,
      state.bannerHeight,
      state.bannerList,
      state.articleList);
}

HomeState _loadingStatusUpdate(HomeState state, LoadStatusAction action) {
  return state.copyWith(
      state.currentPage,
      state.isLoading,
      state.hasMoreData,
      action.status,
      state.bannerHeight,
      state.bannerList,
      state.articleList);
}
