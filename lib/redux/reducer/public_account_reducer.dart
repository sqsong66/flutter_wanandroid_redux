import 'package:flutter_wanandroid_redux/redux/actions/public_account_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/public_account_state.dart';
import 'package:redux/redux.dart';

final publicAccountReducer = combineReducers<PublicAccountState>([
  TypedReducer<PublicAccountState, UpdateAccountTitleAction>(
      _updateAccountTitle),
  TypedReducer<PublicAccountState, UpdateItemIndexAction>(_updateItemIndex),
  TypedReducer<PublicAccountState, UpdateItemLoadingStatusAction>(
      _updateLoadingStatus),
  TypedReducer<PublicAccountState, UpdateItemListAction>(_updateItemList),
  TypedReducer<PublicAccountState, UpdateCollectAction>(_updateCollect),
]);

PublicAccountState _updateAccountTitle(
    PublicAccountState state, UpdateAccountTitleAction action) {
  return state.copyWith(action.dataList, action.accountMap);
}

PublicAccountState _updateItemIndex(
    PublicAccountState state, UpdateItemIndexAction action) {
  var accountMap = state.accountMap;
  PublicAccountItemState itemState = accountMap[action.titleId];
  accountMap[action.titleId] = itemState.copyWith(action.currentPage, true,
      itemState.hasMoreData, itemState.status, itemState.articleList);
  return PublicAccountState(
      accountTitles: state.accountTitles, accountMap: accountMap);
}

PublicAccountState _updateLoadingStatus(
    PublicAccountState state, UpdateItemLoadingStatusAction action) {
  var accountMap = state.accountMap;
  PublicAccountItemState itemState = accountMap[action.titleId];
  accountMap[action.titleId] = itemState.copyWith(
      itemState.currentPage,
      itemState.isLoading,
      itemState.hasMoreData,
      action.status,
      itemState.articleList);
  return PublicAccountState(
      accountTitles: state.accountTitles, accountMap: accountMap);
}

PublicAccountState _updateItemList(
    PublicAccountState state, UpdateItemListAction action) {
  var accountMap = state.accountMap;
  PublicAccountItemState itemState = accountMap[action.titleId];
  accountMap[action.titleId] = itemState.copyWith(itemState.currentPage, false,
      action.hasMoreData, LoadingStatus.success, action.articleList);
  return PublicAccountState(
      accountTitles: state.accountTitles, accountMap: accountMap);
}

PublicAccountState _updateCollect(
    PublicAccountState state, UpdateCollectAction action) {
  var accountMap = state.accountMap;
  PublicAccountItemState itemState = accountMap[action.titleId];
  accountMap[action.titleId] = itemState.copyWith(
      itemState.currentPage,
      itemState.isLoading,
      itemState.hasMoreData,
      itemState.status,
      itemState.articleList);
  return PublicAccountState(
      accountTitles: state.accountTitles, accountMap: accountMap);
}
