import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/model/search_result_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/search_result_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_more_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:flutter_wanandroid_redux/widget/search_bar.dart';
import 'package:flutter_wanandroid_redux/widget/search_result_item.dart';
import 'package:redux/redux.dart';

class SerachResultScreen extends StatelessWidget {
  final String queryText;

  SerachResultScreen({this.queryText});

  PreferredSizeWidget _buildSearchBar(
      BuildContext context, SearchResultViewModel viewModel) {
    double topPadding = MediaQuery.of(context).padding.top;
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Column(
        children: <Widget>[
          Container(
              height: topPadding, color: Theme.of(context).primaryColorDark),
          SearchBar(
            showClose: true,
            autofocus: false,
            defaultText: queryText,
            onSearch: (text) {
              viewModel.startSearch(text);
            },
            onClose: () {
              viewModel.clearResult();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchResultViewModel>(
      onInit: (store) {
        store.dispatch(UpdateQueryTextAction(queryText: queryText));
        store.dispatch(searchArticles(true));
      },
      converter: (Store store) => SearchResultViewModel.fromStore(store),
      builder: (BuildContext context, SearchResultViewModel viewModel) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildSearchBar(context, viewModel),
          body: LoadingView(
              status: viewModel.status,
              errorContent: LoadErrorWidget(),
              loadingContent: LoadingWidget(),
              emptyContent: LoadEmptyWidget(),
              successContent: _buildSearchResult(context, viewModel)),
        );
      },
    );
  }

  Widget _buildSearchResult(
      BuildContext context, SearchResultViewModel viewModel) {
    return LoadMorehWidget<HomeArticle>(
      buildItem: (BuildContext context, article, int index) {
        return SearchResultItem(
          article: article,
          itemClick: (article) {
            _openWebView(context, article.title, article.link);
          },
          onCollect: (article) {
            viewModel.collectArticle(article.id, index, !article.collect);
          },
        );
      },
      dataList: viewModel.articleList,
      hasMoreData: viewModel.hasMoreData,
      isLoading: viewModel.isLoading,
      onLoadMore: () {
        viewModel.loadMore();
      },
      headerWidget: _buildResultWidget(context, viewModel.articleResult),
    );
  }

  Widget _buildResultWidget(BuildContext context, int articleResult) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("RESULT", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(articleResult.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
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
