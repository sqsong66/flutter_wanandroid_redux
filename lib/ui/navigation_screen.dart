import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/data/navigation_bean.dart';
import 'package:flutter_wanandroid_redux/model/navigation_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/navigation_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:redux/redux.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
      ),
      body: StoreConnector<AppState, NavigationViewModel>(
        onInit: (store) {
          store.dispatch(requestNavigationData());
        },
        converter: (Store store) => NavigationViewModel.fromStore(store),
        builder: (BuildContext context, NavigationViewModel viewModel) {
          return LoadingView(
            status: viewModel.status,
            errorContent: LoadErrorWidget(),
            loadingContent: LoadingWidget(),
            emptyContent: LoadEmptyWidget(),
            successContent: _buildNavigationWidget(context, viewModel),
          );
        },
      ),
    );
  }

  Widget _buildNavigationWidget(
      BuildContext context, NavigationViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.navigationList.length,
      itemBuilder: (BuildContext context, int index) {
        NavigationData data = viewModel.navigationList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(data.name, style: TextStyle(fontSize: 18.0)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                  spacing: 8.0,
                  children: data.articles
                      .map((article) => _buildNavigationItem(context, article))
                      .toList()),
            )
          ],
        );
      },
    );
  }

  Widget _buildNavigationItem(BuildContext context, HomeArticle article) {
    return Material(
      color: Colors.transparent,
      child: RawChip(
        onPressed: () => _openWebView(context, article.title, article.link),
        label: Text(article.title),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
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
