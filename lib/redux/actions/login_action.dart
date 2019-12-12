import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction startLogin(String account, String password) {
  return (Store store) async {
    store.dispatch(LoginLoadingAction());
    LoginResult result = await WanAndroidApi.getInstance().login(account, password);
    print("Start login -------------------------------------->");
    if (result.errorCode == 0) {
      store.dispatch(LoginSuccessAction(result.data));
    } else {
      store.dispatch(LoginErrorAction(result.errorMsg));
    }
  };
}

class LoginLoadingAction {
  LoginLoadingAction();
}

class LoginSuccessAction {
  final LoginData loginData;
  LoginSuccessAction(this.loginData);
}

class LoginErrorAction {
  final String errorMessage;
  LoginErrorAction(this.errorMessage);
}
