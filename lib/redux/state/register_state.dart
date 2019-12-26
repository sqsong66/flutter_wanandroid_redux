import 'package:flutter/material.dart';

@immutable
class RegisterState {
  final bool isLoading;
  final int registerStatus; // 0 - idle  1 - success  2 - fail
  final String errorMessage;

  RegisterState(
      {@required this.isLoading,
      @required this.registerStatus,
      @required this.errorMessage});

  factory RegisterState.initial() {
    return RegisterState(
        isLoading: false, registerStatus: 0, errorMessage: null);
  }

  RegisterState copyWith(
      bool isLoading, int registerStatus, String errorMessage) {
    return RegisterState(
        isLoading: isLoading ?? this.isLoading,
        registerStatus: registerStatus ?? this.registerStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
