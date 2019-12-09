import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
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
  final Function(ProjectClassifyData) onClassifyDataChanged;

  ProjectViewModel(
      {this.isLoading,
      this.hasMoreData,
      this.status,
      this.currentClassifyData,
      this.classifyList,
      this.onClassifyDataChanged});

  static ProjectViewModel fromStore(Store<AppState> store) {
    return ProjectViewModel(
        isLoading: store.state.projectState.isLoading,
        hasMoreData: store.state.projectState.hasMoreData,
        status: store.state.projectState.status,
        currentClassifyData: store.state.projectState.currentClassifyData,
        classifyList: store.state.projectState.classifyList,
        onClassifyDataChanged: (ProjectClassifyData classfiyData) {
          List<ProjectClassifyData> classifyList =
              store.state.projectState.classifyList;
          store.dispatch(ProjectClassifyUpdateAction(
              classifyData: classfiyData, classifyList: classifyList));
        });
  }
}
