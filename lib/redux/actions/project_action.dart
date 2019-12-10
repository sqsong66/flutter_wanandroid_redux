import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/base_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      store.dispatch(requestProjectDataAction(true));
    } else {
      store.dispatch(ProjectLoadStatusAction(status: LoadingStatus.error));
    }
  };
}

ThunkAction<AppState> requestProjectDataAction(bool isRefresh) {
  return (Store<AppState> store) async {
    try {
      var projectState = store.state.projectState;
      int currentPage = isRefresh ? 1 : projectState.currentPage + 1;
      HomeArticleBean bean = await WanAndroidApi.getInstance()
          .requestProjectData(currentPage, projectState.currentClassifyData.id);
      if (bean.errorCode == 0 && bean.data != null) {
        List<HomeArticle> projectList = store.state.projectState.projectList;
        if (isRefresh) projectList.clear();
        projectList.addAll(bean.data.datas);
        bool hasMoreData = projectList.length < bean.data.total;
        store.dispatch(ProjectDataUpdateAction(
            currentPage: currentPage,
            hasMoreData: hasMoreData,
            projectList: projectList));
      } else {
        if (isRefresh) {
          store.dispatch(ProjectLoadStatusAction(status: LoadingStatus.error));
        } else {
          Fluttertoast.showToast(msg: "Something wrong.");
        }
      }
    } catch (e) {
      print(e.toString());
      if (isRefresh) {
        store.dispatch(ProjectLoadStatusAction(status: LoadingStatus.error));
      } else {
        Fluttertoast.showToast(msg: "Something wrong.");
      }
    }
  };
}

ThunkAction<AppState> starProjectAction(
    int articleId, int articleIndex, bool isCollect) {
  return (Store<AppState> store) async {
    BaseData data =
        await WanAndroidApi.getInstance().collectArticle(articleId, isCollect);
    if (data != null && data.errorCode == 0) {
      List<HomeArticle> articleList = store.state.projectState.projectList;
      if (articleIndex >= 0 && articleIndex < articleList.length) {
        articleList[articleIndex].collect = isCollect;
        store.dispatch(CollectArticleAction());
        String message = isCollect ? "收藏成功" : "取消收藏成功";
        Fluttertoast.showToast(msg: message);
      }
    } else {
      Fluttertoast.showToast(msg: data.errorMsg);
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

  ProjectClassifyUpdateAction({@required this.classifyData, this.classifyList});
}

class ProjectDataUpdateAction {
  final int currentPage;
  final bool hasMoreData;
  final List<HomeArticle> projectList;

  ProjectDataUpdateAction(
      {this.currentPage, this.hasMoreData, this.projectList});
}
