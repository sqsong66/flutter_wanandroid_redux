import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/pre_search_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class PreSearchModel {
  final List<HotSearch> hotKeyList;
  final List<String> historyList;
  final Function(String, bool) deleteAction;

  PreSearchModel(
      {@required this.hotKeyList,
      @required this.historyList,
      @required this.deleteAction});

  static PreSearchModel fromStore(Store<AppState> store) {
    return PreSearchModel(
        hotKeyList: store.state.searchActionState.hotKeyList,
        historyList: store.state.searchActionState.historyList,
        deleteAction: (keyWord, isClear) {
          store.dispatch(deleteSearchKey(keyWord, isClear));
        });
  }
}
