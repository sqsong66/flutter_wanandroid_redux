import 'package:flutter_wanandroid_redux/redux/reducer/home_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/reducer/login_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/reducer/project_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/reducer/search_action_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/reducer/search_result_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';

AppState appReducer(AppState appState, dynamic action) {
  return AppState(
      loginState: loginReducer(appState.loginState, action),
      homeState: homeReducer(appState.homeState, action),
      projectState: projectReducer(appState.projectState, action),
      searchActionState:
          searchActionReducer(appState.searchActionState, action),
      searchResultSate: searchResultReducer(appState.searchResultSate, action));
}
