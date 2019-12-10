import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/redux/state/home_state.dart';
import 'package:meta/meta.dart';

@immutable
class ProjectState {
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final LoadingStatus status;
  final ProjectClassifyData currentClassifyData;
  final List<ProjectClassifyData> classifyList;
  final List<HomeArticle> projectList;

  ProjectState(
      {@required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.status,
      @required this.currentClassifyData,
      @required this.classifyList,
      @required this.projectList});

  factory ProjectState.initial() {
    return ProjectState(
        currentPage: 1,
        isLoading: false,
        hasMoreData: true,
        status: LoadingStatus.idle,
        currentClassifyData: null,
        classifyList: [],
        projectList: []);
  }

  ProjectState copyWith(
      int currentPage,
      bool isLoading,
      bool hasMoreData,
      LoadingStatus status,
      ProjectClassifyData currentClassifyData,
      List<ProjectClassifyData> classifyList,
      List<HomeArticle> projectList) {
    return ProjectState(
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        status: status ?? this.status,
        currentClassifyData: currentClassifyData ?? this.currentClassifyData,
        classifyList: classifyList ?? this.classifyList,
        projectList: projectList ?? this.projectList);
  }
}
