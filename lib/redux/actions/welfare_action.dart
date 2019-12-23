import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/welfare_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestWelfare(bool isRefresh) {
  return (Store<AppState> store) async {
    int currentPage =
        isRefresh ? 1 : store.state.welfareState.currentPage + 1;
    store.dispatch(UpdateWelfareIndexAction(currentPage: currentPage));
    try {
      WelfareBean welfareBean =
          await WanAndroidApi.getInstance().requestWelfareData(currentPage);
      if (!welfareBean.error) {
        List<WelfareData> dataList = store.state.welfareState.dataList;
        if (isRefresh) dataList.clear();
        List<WelfareData> results = welfareBean.results;
        if (isRefresh && (results == null || results.isEmpty)) {
          store
              .dispatch(UpdateWelfareStatusAction(status: LoadingStatus.empty));
          return;
        }
        dataList.addAll(results);
        bool hasMoreData = results.isNotEmpty;
        store.dispatch(UpdateWelfareDataAction(
            hasMoreData: hasMoreData, welfareList: dataList));
      } else {
        if (isRefresh) {
          store
              .dispatch(UpdateWelfareStatusAction(status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: "Something wrong.");
        }
      }
    } catch (e) {
      print(e);
      if (isRefresh) {
        store.dispatch(UpdateWelfareStatusAction(status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

class UpdateWelfareIndexAction {
  final int currentPage;
  UpdateWelfareIndexAction({@required this.currentPage});
}

class UpdateWelfareStatusAction {
  final LoadingStatus status;
  UpdateWelfareStatusAction({@required this.status});
}

class UpdateWelfareDataAction {
  final bool hasMoreData;
  final List<WelfareData> welfareList;
  UpdateWelfareDataAction(
      {@required this.hasMoreData, @required this.welfareList});
}
