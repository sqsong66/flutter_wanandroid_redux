import 'package:flutter_wanandroid_redux/redux/actions/welfare_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/welfare_state.dart';
import 'package:redux/redux.dart';

final welfareReducer = combineReducers<WelfareState>([
  TypedReducer<WelfareState, UpdateWelfareIndexAction>(_updateIndex),
  TypedReducer<WelfareState, UpdateWelfareStatusAction>(_updateStatus),
  TypedReducer<WelfareState, UpdateWelfareDataAction>(_updateWelfare),
]);

WelfareState _updateIndex(WelfareState state, UpdateWelfareIndexAction action) {
  return state.copyWith(action.currentPage, true, state.hasMoreData,
      state.status, state.dataList);
}

WelfareState _updateStatus(
    WelfareState state, UpdateWelfareStatusAction action) {
  return state.copyWith(state.currentPage, state.isLoading, state.hasMoreData,
      action.status, state.dataList);
}

WelfareState _updateWelfare(
    WelfareState state, UpdateWelfareDataAction action) {
  return state.copyWith(state.currentPage, false, action.hasMoreData,
      LoadingStatus.success, action.welfareList);
}
