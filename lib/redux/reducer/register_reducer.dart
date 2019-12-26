import 'package:flutter_wanandroid_redux/redux/actions/register_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/register_state.dart';
import 'package:redux/redux.dart';

final registerReducer = combineReducers<RegisterState>([
  TypedReducer<RegisterState, UpdateLoadingAction>(_updateLoadingState),
  TypedReducer<RegisterState, UpdateRegisterAction>(_updateRegister),
]);

RegisterState _updateLoadingState(
    RegisterState state, UpdateLoadingAction action) {
  return state.copyWith(
      action.isLoading, state.registerStatus, state.errorMessage);
}

RegisterState _updateRegister(
    RegisterState state, UpdateRegisterAction action) {
  return state.copyWith(false, action.registerStatus, action.errorMessage);
}
