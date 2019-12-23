import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/welfare_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/welfare_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

class WelfareViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<WelfareData> dataList;
  final Function(bool isRefresh) refreshEvents;

  WelfareViewModel(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.dataList,
      @required this.refreshEvents});

  static WelfareViewModel fromStore(Store<AppState> store) {
    return WelfareViewModel(
        isLoading: store.state.welfareState.isLoading,
        hasMoreData: store.state.welfareState.hasMoreData,
        status: store.state.welfareState.status,
        dataList: store.state.welfareState.dataList,
        refreshEvents: (isRefresh) {
          store.dispatch(requestWelfare(isRefresh));
        });
  }
}
