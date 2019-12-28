import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> startRegister(
    String account, String password, String confirmPassword) {
  return (Store<AppState> store) async {
    store.dispatch(UpdateRegisterLoadingAction(isLoading: true));
    LoginResult result = await WanAndroidApi.getInstance()
        .register(account, password, confirmPassword);
    store.dispatch(UpdateRegisterAction(registerStatus: 1, errorMessage: ""));
    if (result.errorCode == 0) {
    } else {
      store.dispatch(UpdateRegisterAction(
          registerStatus: 2, errorMessage: result.errorMsg));
    }
  };
}

class UpdateRegisterLoadingAction {
  final bool isLoading;
  UpdateRegisterLoadingAction({@required this.isLoading});
}

class UpdateRegisterAction {
  final int registerStatus; // 0 - idle  1 - success  2 - fail
  final String errorMessage;
  UpdateRegisterAction(
      {@required this.registerStatus, @required this.errorMessage});
}
