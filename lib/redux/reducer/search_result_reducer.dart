import 'package:flutter_wanandroid_redux/redux/actions/search_result_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/search_result_state.dart';
import 'package:redux/redux.dart';

final searchResultReducer = combineReducers<SearchResultSate>([
  TypedReducer<SearchResultSate, UpdateQueryTextAction>(_updateQueryText),
  TypedReducer<SearchResultSate, UpdatePageIndexAction>(_updatePageIndex),
  TypedReducer<SearchResultSate, UpdateLoadingStatusAction>(
      _updateLoadingStatus),
]);

SearchResultSate _updateQueryText(
    SearchResultSate state, UpdateQueryTextAction action) {
  return state.copyWith(action.queryText, state.currentPage, state.isLoading,
      state.hasMoreData, state.status, state.articleList);
}

SearchResultSate _updatePageIndex(
    SearchResultSate state, UpdatePageIndexAction action) {
  return state.copyWith(state.queryText, action.currentPage, true,
      state.hasMoreData, state.status, state.articleList);
}

SearchResultSate _updateLoadingStatus(
    SearchResultSate state, UpdateLoadingStatusAction action) {
  return state.copyWith(state.queryText, state.currentPage, state.isLoading,
      state.hasMoreData, action.status, state.articleList);
}
