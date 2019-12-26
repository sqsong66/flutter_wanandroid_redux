import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/collection_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/collection_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/collection_result_item.dart';
import 'package:flutter_wanandroid_redux/widget/home_refresh_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:redux/redux.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Collection")),
      body: StoreConnector<AppState, CollectionViewModel>(
        onInit: (store) {
          store.dispatch(requestCollectionData(true));
        },
        converter: (Store store) => CollectionViewModel.fromStore(store),
        builder: (BuildContext context, CollectionViewModel viewModel) {
          return LoadingView(
            status: viewModel.status,
            loadingContent: LoadingWidget(),
            emptyContent: LoadEmptyWidget(),
            errorContent: LoadErrorWidget(
              onRetry: () {
                viewModel.loadArticles(true);
              },
            ),
            successContent: _buildContent(viewModel),
          );
        },
      ),
    );
  }

  _buildContent(CollectionViewModel viewModel) {
    return HomeRefreshWidget(
      isLoading: viewModel.isLoading,
      hasMoreData: viewModel.hasMoreData,
      headerWidget: null,
      refreshData: () {
        viewModel.loadArticles(true);
        return Future.delayed(Duration(milliseconds: 1000));
      },
      dataList: viewModel.articleList,
      onLoadMore: () {
        viewModel.loadArticles(false);
      },
      buildItem: (BuildContext context, article, int index) {
        return CollectionResultItem(
          article: article,
          itemClick: (article) {
            _openWebView(context, article.title, article.link);
          },
          onCollect: (article) {
            viewModel.removeCollectionArticle(article.id, index);
          },
        );
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
}
