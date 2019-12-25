import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/login_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/navigation_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/project_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/public_account_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/search_action_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/search_result_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/welfare_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final LoginState loginState;
  final HomeState homeState;
  final ProjectState projectState;
  final SearchActionState searchActionState;
  final SearchResultSate searchResultSate;
  final WelfareState welfareState;
  final NavigationState navigationState;
  final PublicAccountState publicAccountState;

  AppState(
      {this.loginState,
      this.homeState,
      this.projectState,
      this.searchActionState,
      this.searchResultSate,
      this.welfareState,
      this.navigationState,
      this.publicAccountState});

  factory AppState.initial() {
    return AppState(
        loginState: LoginState.initial(),
        homeState: HomeState.initial(),
        projectState: ProjectState.initial(),
        searchActionState: SearchActionState.initial(),
        searchResultSate: SearchResultSate.initial(),
        welfareState: WelfareState.initial(),
        navigationState: NavigationState.initial(),
        publicAccountState: PublicAccountState.initial());
  }
}
