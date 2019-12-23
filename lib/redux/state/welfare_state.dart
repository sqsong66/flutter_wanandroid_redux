import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/welfare_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';

@immutable
class WelfareState {
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final List<WelfareData> dataList;

  WelfareState(
      {@required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.dataList});

  factory WelfareState.initial() {
    return WelfareState(
        currentPage: 1,
        isLoading: false,
        hasMoreData: true,
        status: LoadingStatus.idle,
        dataList: []);
  }

  WelfareState copyWith(int currentPage, bool isLoading, bool hasMoreData,
      LoadingStatus status, List<WelfareData> dataList) {
    return WelfareState(
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        dataList: dataList ?? this.dataList);
  }
}
