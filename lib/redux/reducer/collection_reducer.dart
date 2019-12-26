import 'package:flutter_wanandroid_redux/redux/actions/collection_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/collection_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

final collectionReducer = combineReducers<CollectionState>([
  TypedReducer<CollectionState, UpdateCollectionIndexAction>(
      _updateCollectionIndex),
  TypedReducer<CollectionState, UpdateCollectStatusAction>(
      _updateCollectionLoadingStatus),
  TypedReducer<CollectionState, UpdateCollectDataAction>(_updateCollectionData),
]);

CollectionState _updateCollectionIndex(
    CollectionState state, UpdateCollectionIndexAction action) {
  return state.copyWith(action.currentPage, true, state.hasMoreData,
      state.status, state.articleList);
}

CollectionState _updateCollectionLoadingStatus(
    CollectionState state, UpdateCollectStatusAction action) {
  return state.copyWith(state.currentPage, state.isLoading, state.hasMoreData,
      action.status, state.articleList);
}

CollectionState _updateCollectionData(
    CollectionState state, UpdateCollectDataAction action) {
  return state.copyWith(state.currentPage, false, action.hasMoreData,
      LoadingStatus.success, action.articleList);
}
