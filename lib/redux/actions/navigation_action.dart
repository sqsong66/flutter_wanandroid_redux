import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/navigation_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestNavigationData() {
  return (Store<AppState> store) async {
    try {
      NavigationBean bean =
          await WanAndroidApi.getInstance().requestNavigationData();
      if (bean.errorCode == 0) {
        List<NavigationData> dataList = bean.data;
        if (dataList.isNotEmpty) {
          store.dispatch(UpdateNavigationDataAction(dataList: dataList));
        } else {
          store.dispatch(
              UpdateNavigationStatusAction(status: LoadingStatus.empty));
        }
      } else {
        store.dispatch(
            UpdateNavigationStatusAction(status: LoadingStatus.error));
      }
    } catch (e) {
      print(e);
      store.dispatch(UpdateNavigationStatusAction(status: LoadingStatus.error));
    }
  };
}

class UpdateNavigationStatusAction {
  final LoadingStatus status;
  UpdateNavigationStatusAction({@required this.status});
}

class UpdateNavigationDataAction {
  final List<NavigationData> dataList;
  UpdateNavigationDataAction({@required this.dataList});
}
