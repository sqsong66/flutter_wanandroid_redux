import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/redux/actions/register_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class RegisterViewModel {
  final int type; // 0-login, 1-register
  final bool isLoading;
  final int registerStatus; // 0 - idle  1 - success  2 - fail
  final String errorMessage;
  final Function(String, String, String) register;

  RegisterViewModel(
      {this.type,
      @required this.isLoading,
      @required this.registerStatus,
      @required this.errorMessage,
      @required this.register});

  static RegisterViewModel fromStore(Store<AppState> store) {
    return RegisterViewModel(
        type: store.state.registerState.type,
        isLoading: store.state.registerState.isLoading,
        registerStatus: store.state.registerState.registerStatus,
        errorMessage: store.state.registerState.errorMessage,
        register: (account, password, confirmPassword) {
          store.dispatch(startRegister(account, password, confirmPassword));
        });
  }
}
