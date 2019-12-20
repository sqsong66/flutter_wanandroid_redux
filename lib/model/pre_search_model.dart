import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class PreSearchModel {
  final List<HotSearch> hotKeyList;
  final List<String> historyList;

  PreSearchModel({@required this.hotKeyList, @required this.historyList});

  static PreSearchModel fromStore(Store<AppState> store) {
    return PreSearchModel(
        hotKeyList: store.state.searchActionState.hotKeyList,
        historyList: store.state.searchActionState.historyList);
  }
}
