import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/actions/project_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/project_state.dart';
import 'package:redux/redux.dart';

final projectReducer = combineReducers<ProjectState>([
  TypedReducer<ProjectState, ProjectLoadStatusAction>(_updateLoadingState),
  TypedReducer<ProjectState, ProjectClassifyUpdateAction>(_updateClassifyData),
  TypedReducer<ProjectState, ProjectDataUpdateAction>(_updateProjectList),
  TypedReducer<ProjectState, CollectArticleAction>(_collectUpdate),
]);

ProjectState _updateLoadingState(
    ProjectState state, ProjectLoadStatusAction action) {
  return state.copyWith(
      state.currentPage,
      state.isLoading,
      state.hasMoreData,
      action.status,
      state.currentClassifyData,
      state.classifyList,
      state.projectList);
}

ProjectState _updateClassifyData(
    ProjectState state, ProjectClassifyUpdateAction action) {
  return state.copyWith(1, state.isLoading, state.hasMoreData, state.status,
      action.classifyData, action.classifyList, state.projectList);
}

ProjectState _updateProjectList(
    ProjectState state, ProjectDataUpdateAction action) {
  return state.copyWith(
      action.currentPage,
      false,
      action.hasMoreData,
      LoadingStatus.success,
      state.currentClassifyData,
      state.classifyList,
      action.projectList);
}

ProjectState _collectUpdate(ProjectState state, CollectArticleAction action) {
  return state.copyWith(
      state.currentPage,
      state.isLoading,
      state.hasMoreData,
      state.status,
      state.currentClassifyData,
      state.classifyList,
      state.projectList);
}
