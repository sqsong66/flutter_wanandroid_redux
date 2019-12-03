import 'package:flutter_wanandroid_redux/redux/actions/login_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/login_state.dart';
import 'package:redux/redux.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, LoginLoadingAction>(_loginLoading),
  TypedReducer<LoginState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<LoginState, LoginErrorAction>(_loginError),
]);

LoginState _loginLoading(LoginState state, LoginLoadingAction action) {
  return state.copyWith(true, 0, null, state.loginData);
}

LoginState _loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(false, 1, null, action.loginData);
}

LoginState _loginError(LoginState state, LoginErrorAction action) {
  return state.copyWith(false, 2, action.errorMessage, state.loginData);
}
