import 'package:flutter_wanandroid_redux/redux/actions/pre_search_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/search_action_state.dart';
import 'package:redux/redux.dart';

final searchActionReducer = combineReducers<SearchActionState>([
  TypedReducer<SearchActionState, UpdateHotKeyAction>(_updateSearchList),
]);

SearchActionState _updateSearchList(
    SearchActionState state, UpdateHotKeyAction action) {
  return state.copyWith(action.hotKeyList, state.historyList);
}
