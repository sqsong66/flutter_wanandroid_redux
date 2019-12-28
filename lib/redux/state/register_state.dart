import 'package:flutter/material.dart';

@immutable
class RegisterState {
  final int type; // 0-login, 1-register
  final bool isLoading;
  final int registerStatus; // 0 - idle  1 - success  2 - fail
  final String errorMessage;

  RegisterState(
      {@required this.type,
      @required this.isLoading,
      @required this.registerStatus,
      @required this.errorMessage});

  factory RegisterState.initial() {
    return RegisterState(
        type: 1, isLoading: false, registerStatus: 0, errorMessage: null);
  }

  RegisterState copyWith(
      bool isLoading, int registerStatus, String errorMessage) {
    return RegisterState(
        type: 1,
        isLoading: isLoading ?? this.isLoading,
        registerStatus: registerStatus ?? this.registerStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
