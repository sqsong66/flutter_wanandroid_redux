import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/actions/project_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:redux/redux.dart';

class ProjectViewModel {
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final ProjectClassifyData currentClassifyData;
  final List<ProjectClassifyData> classifyList;
  final List<HomeArticle> projectList;
  final Function(bool isRefresh) refreshEvents;
  final Function retryEvents;
  final Function(ProjectClassifyData) onClassifyDataChanged;
  final Function(int articleId, int articleIndex, bool isCollect) starArticle;

  ProjectViewModel(
      {this.isLoading,
      this.hasMoreData,
      this.status,
      this.currentClassifyData,
      this.classifyList,
      this.projectList,
      this.refreshEvents,
      this.retryEvents,
      this.onClassifyDataChanged,
      this.starArticle});

  static ProjectViewModel fromStore(Store<AppState> store) {
    return ProjectViewModel(
        isLoading: store.state.projectState.isLoading,
        hasMoreData: store.state.projectState.hasMoreData,
        status: store.state.projectState.status,
        currentClassifyData: store.state.projectState.currentClassifyData,
        classifyList: store.state.projectState.classifyList,
        projectList: store.state.projectState.projectList,
        refreshEvents: (isRefresh) {
          store.dispatch(requestProjectDataAction(isRefresh));
        },
        retryEvents: () {
          store.dispatch(requestProjectClassifyAction());
        },
        onClassifyDataChanged: (ProjectClassifyData classfiyData) {
          store.dispatch(
              ProjectClassifyUpdateAction(classifyData: classfiyData));
          store.dispatch(requestProjectDataAction(true));
        },
        starArticle: (articleId, articleIndex, isCollect) {
          store.dispatch(
              collectArticleAction(articleId, articleIndex, isCollect, 1));
        });
  }
}
