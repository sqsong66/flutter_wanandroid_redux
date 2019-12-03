import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_wanandroid_redux/redux/actions/login_action.dart';

class LoginViewModel {
  final bool isLoading;
  final int loginStatus;
  final String errorMessage;
  final LoginData loginData;

  final Function(String, String) login;

  LoginViewModel(
      {this.isLoading, this.loginStatus, this.errorMessage, this.loginData, this.login});

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      isLoading: store.state.loginState.isLoading,
      loginStatus: store.state.loginState.loginStatus,
      errorMessage: store.state.loginState.errorMessage,
      loginData: store.state.loginState.loginData,
      login: (String account, String password) {
        store.dispatch(startLogin(account, password));
      }
    );
  }
}
