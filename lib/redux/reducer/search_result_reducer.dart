import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/actions/search_result_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/search_result_state.dart';
import 'package:redux/redux.dart';

final searchResultReducer = combineReducers<SearchResultSate>([
  TypedReducer<SearchResultSate, UpdateQueryTextAction>(_updateQueryText),
  TypedReducer<SearchResultSate, UpdatePageIndexAction>(_updatePageIndex),
  TypedReducer<SearchResultSate, UpdateLoadingStatusAction>(
      _updateLoadingStatus),
  TypedReducer<SearchResultSate, UpdateArticlesAction>(_updateArticles),
  TypedReducer<SearchResultSate, CollectArticleAction>(_collectUpdate),
  TypedReducer<SearchResultSate, ClearResultAction>(_clearResult),
]);

SearchResultSate _updateQueryText(
    SearchResultSate state, UpdateQueryTextAction action) {
  return state.copyWith(action.queryText, state.currentPage, state.isLoading,
      state.hasMoreData, state.articleResult, state.status, state.articleList);
}

SearchResultSate _updatePageIndex(
    SearchResultSate state, UpdatePageIndexAction action) {
  return state.copyWith(state.queryText, action.currentPage, true,
      state.hasMoreData, state.articleResult, state.status, state.articleList);
}

SearchResultSate _updateLoadingStatus(
    SearchResultSate state, UpdateLoadingStatusAction action) {
  return state.copyWith(state.queryText, state.currentPage, state.isLoading,
      state.hasMoreData, state.articleResult, action.status, state.articleList);
}

SearchResultSate _updateArticles(
    SearchResultSate state, UpdateArticlesAction action) {
  return state.copyWith(
      state.queryText,
      state.currentPage,
      false,
      action.hasMoreData,
      action.articleResult,
      LoadingStatus.success,
      action.articleList);
}

SearchResultSate _collectUpdate(
    SearchResultSate state, CollectArticleAction action) {
  return state.copyWith(state.queryText, state.currentPage, state.isLoading,
      state.hasMoreData, state.articleResult, state.status, state.articleList);
}

SearchResultSate _clearResult(SearchResultSate state, ClearResultAction action) {
  return state.copyWith("", 0, false, true, 0, LoadingStatus.empty, []);
}