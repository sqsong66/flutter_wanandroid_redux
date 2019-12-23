import 'package:flutter_wanandroid_redux/redux/actions/navigation_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/navigation_state.dart';
import 'package:redux/redux.dart';

final navigationReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdateNavigationStatusAction>(_updateStatus),
  TypedReducer<NavigationState, UpdateNavigationDataAction>(
      _updateNavigationData),
]);

NavigationState _updateStatus(
    NavigationState state, UpdateNavigationStatusAction action) {
  return state.copyWith(action.status, state.navigationList);
}

NavigationState _updateNavigationData(
    NavigationState state, UpdateNavigationDataAction action) {
  return state.copyWith(LoadingStatus.success, action.dataList);
}
