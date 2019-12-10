import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/model/project_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/project_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/home_refresh_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:flutter_wanandroid_redux/widget/project_appbar.dart';
import 'package:flutter_wanandroid_redux/widget/project_item_widget.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with AutomaticKeepAliveClientMixin<ProjectScreen> {
  Text _titleText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold));
  }

  Widget _buildAppBar(ProjectViewModel viewModel) {
    if (viewModel.currentClassifyData == null || viewModel.classifyList.isEmpty)
      return AppBar(title: _titleText("Project"));
    return PreferredSize(
      child: ProjectAppBar(
        classifyData: viewModel.currentClassifyData,
        classifyList: viewModel.classifyList,
        onClassifyDataTap: (data) {
          viewModel.onClassifyDataChanged(data);
        },
      ),
      preferredSize: const Size.fromHeight(kToolbarHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, ProjectViewModel>(
      onInit: (store) {
        store.dispatch(requestProjectClassifyAction());
      },
      converter: (store) => ProjectViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          body: LoadingView(
            status: viewModel.status,
            loadingContent: LoadingWidget(),
            errorContent: LoadErrorWidget(
              onRetry: () {
                viewModel.retryEvents();
              },
            ),
            successContent: _buildContent(viewModel),
          ),
        );
      },
    );
  }

  Widget _buildContent(ProjectViewModel viewModel) {
    return HomeRefreshWidget<HomeArticle>(
      isLoading: viewModel.isLoading,
      hasMoreData: viewModel.hasMoreData,
      dataList: viewModel.projectList,
      headerWidget: null,
      refreshData: () async {
        viewModel.refreshEvents(true);
        return Future.delayed(Duration(milliseconds: 1500));
      },
      onLoadMore: () {
        viewModel.refreshEvents(false);
      },
      buildItem: (BuildContext context, dynamic data, int index) {
        return data is HomeArticle
            ? _buildProjectItem(viewModel, data, index)
            : Container();
      },
    );
  }

  Widget _buildProjectItem(
      ProjectViewModel viewModel, HomeArticle article, int index) {
    return ProjectItemWidget(
      article: article,
      onItemClick: (title, link) => _openWebView(context, title, link),
      onStar: (article) {
        viewModel.starArticle(article.id, index, !article.collect);
      },
    );
  }

  void _openWebView(BuildContext context, String title, String link) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: title,
          initUrl: link,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
