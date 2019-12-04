import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, HomeBannerUpdated>(_refreshBanner),
]);

HomeState _refreshBanner(HomeState state, HomeBannerUpdated action) {
  return state.copyWith(state.status, action.bannerList, state.articleList);
}