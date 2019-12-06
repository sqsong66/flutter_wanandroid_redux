import 'package:flutter_wanandroid_redux/redux/reducer/home_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/reducer/login_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';

AppState appReducer(AppState appState, dynamic action) {
  return AppState(
    loginState: loginReducer(appState.loginState, action),
    homeState: homeReducer(appState.homeState, action),
  );
}
