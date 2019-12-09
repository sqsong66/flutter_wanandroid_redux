import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/login_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/project_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final LoginState loginState;
  final HomeState homeState;
  final ProjectState projectState;

  AppState({this.loginState, this.homeState, this.projectState});

  factory AppState.initial() {
    return AppState(
        loginState: LoginState.initial(),
        homeState: HomeState.initial(),
        projectState: ProjectState.initial());
  }
}
