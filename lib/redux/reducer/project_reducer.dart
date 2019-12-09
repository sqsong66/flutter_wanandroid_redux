import 'package:flutter_wanandroid_redux/redux/actions/project_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/project_state.dart';
import 'package:redux/redux.dart';

final projectReducer = combineReducers<ProjectState>([
  TypedReducer<ProjectState, ProjectLoadStatusAction>(_updateLoadingState),
  TypedReducer<ProjectState, ProjectClassifyUpdateAction>(
      _updateProjectClassify),
]);

ProjectState _updateLoadingState(
    ProjectState state, ProjectLoadStatusAction action) {
  return state.copyWith(state.currentPage, state.isLoading, state.hasMoreData,
      action.status, state.currentClassifyData, state.classifyList);
}

ProjectState _updateProjectClassify(
    ProjectState state, ProjectClassifyUpdateAction action) {
  return state.copyWith(state.currentPage, state.isLoading, state.hasMoreData,
      state.status, action.classifyData, action.classifyList);
}
