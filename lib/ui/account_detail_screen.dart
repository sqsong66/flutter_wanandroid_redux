import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/public_account_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/public_account_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/state/public_account_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/home_refresh_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:flutter_wanandroid_redux/widget/search_result_item.dart';
import 'package:redux/redux.dart';

class AccountDetailScreen extends StatefulWidget {
  final int titleId;

  const AccountDetailScreen({Key key, this.titleId}) : super(key: key);

  @override
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen>
    with AutomaticKeepAliveClientMixin<AccountDetailScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, PublicAccountViewModel>(
      onInit: (store) {
        store.dispatch(requestAccountData(widget.titleId, true));
      },
      converter: (Store store) => PublicAccountViewModel.fromStore(store),
      builder: (BuildContext context, PublicAccountViewModel viewModel) {
        return LoadingView(
          status: viewModel.accountMap[widget.titleId].status,
          loadingContent: LoadingWidget(),
          emptyContent: LoadEmptyWidget(),
          errorContent: LoadErrorWidget(
            onRetry: () {
              // viewModel.retryEvents();
            },
          ),
          successContent:
              _buildContent(viewModel, viewModel.accountMap[widget.titleId]),
        );
      },
    );
  }

  Widget _buildContent(
      PublicAccountViewModel viewModel, PublicAccountItemState itemState) {
    return HomeRefreshWidget(
      isLoading: itemState.isLoading,
      hasMoreData: itemState.hasMoreData,
      dataList: itemState.articleList,
      headerWidget: null,
      buildItem: (BuildContext context, article, int index) {
        return SearchResultItem(
          article: article,
          itemClick: (article) {
            _openWebView(context, article.title, article.link);
          },
          onCollect: (article) {
            viewModel.collectArticle(
                widget.titleId, article.id, index, !article.collect);
          },
        );
      },
      onLoadMore: () {
        viewModel.loadArticleEvent(widget.titleId, false);
      },
      refreshData: () {
        viewModel.loadArticleEvent(widget.titleId, true);
        return Future.delayed(Duration(milliseconds: 1000));
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
