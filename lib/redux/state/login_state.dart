import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final int type; // 0-login, 1-register
  final bool isLoading;
  final int loginStatus; // 0 - idle  1 - success  2 - fail
  final String errorMessage;
  final LoginData loginData;

  LoginState(
      {@required this.type,
      @required this.isLoading,
      @required this.loginStatus,
      @required this.errorMessage,
      @required this.loginData});

  factory LoginState.initial() {
    return LoginState(
        type: 0,
        isLoading: false,
        loginStatus: 0,
        errorMessage: null,
        loginData: null);
  }

  LoginState copyWith(bool isLoading, int loginStatus, String errorMassage,
      LoginData loginData) {
    return LoginState(
        type: 0,
        isLoading: isLoading ?? this.isLoading,
        loginStatus: loginStatus ?? this.loginStatus,
        errorMessage: errorMassage ?? this.errorMessage,
        loginData: loginData ?? this.loginData);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          loginStatus == other.loginStatus &&
          errorMessage == other.errorMessage &&
          loginData == other.loginData;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      loginStatus.hashCode ^
      errorMessage.hashCode ^
      loginData.hashCode;
}
