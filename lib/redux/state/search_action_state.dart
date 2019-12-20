import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';

@immutable
class SearchActionState {
  final List<HotSearch> hotKeyList;
  final List<String> historyList;

  SearchActionState({@required this.hotKeyList, @required this.historyList});

  factory SearchActionState.initial() {
    return SearchActionState(hotKeyList: null, historyList: null);
  }

  SearchActionState copyWith(
      List<HotSearch> hotKeyList, List<String> historyList) {
    return SearchActionState(
        hotKeyList: hotKeyList ?? this.hotKeyList,
        historyList: historyList ?? this.historyList);
  }
}
