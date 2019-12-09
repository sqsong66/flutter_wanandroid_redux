import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestProjectClassifyAction() {
  return (Store<AppState> store) async {
    ProjectClassifyBean bean =
        await WanAndroidApi.getInstance().requestProjectClassify();
    if (bean.errorCode == 0 && bean.data != null && bean.data.isNotEmpty) {
      List<ProjectClassifyData> classifyList = bean.data;
      store.dispatch(ProjectClassifyUpdateAction(
          classifyData: classifyList[0], classifyList: classifyList));
    } else {
      store.dispatch(ProjectLoadStatusAction(status: LoadingStatus.error));
    }
  };
}

class ProjectLoadStatusAction {
  final LoadingStatus status;
  ProjectLoadStatusAction({this.status});
}

class ProjectClassifyUpdateAction {
  final ProjectClassifyData classifyData;
  final List<ProjectClassifyData> classifyList;

  ProjectClassifyUpdateAction({@required this.classifyData, @required this.classifyList});
}
