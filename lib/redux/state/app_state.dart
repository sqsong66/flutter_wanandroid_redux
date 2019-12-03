import 'package:flutter_wanandroid_redux/redux/state/login_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final LoginState loginState;
  
  AppState({this.loginState});

  factory AppState.initial() {
    return AppState(loginState: LoginState.initial());
  }
}