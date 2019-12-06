import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/model/home_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/widget/banner_widget.dart';
import 'package:flutter_wanandroid_redux/widget/home_article_widget.dart';
import 'package:flutter_wanandroid_redux/widget/home_refresh_widget.dart';

class HomeScreen extends StatefulWidget {
  final String titleText;

  HomeScreen({this.titleText});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, HomeViewModel>(
        onInit: (store) {
          store.dispatch(refreshBannerData(context));
          store.dispatch(loadHomeArticle(true));
        },
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, viewModel) {
          return HomeRefreshWidget<HomeArticle>(
            isLoading: viewModel.isLoading,
            hasMoreData: viewModel.hasMoreData,
            dataList: viewModel.articleList,
            headerWidget: BannerWidget(
              bannerLists: viewModel.bannerList,
              bannerHeight: viewModel.bannerHeight,
            ),
            refreshData: () async {
              viewModel.refreshEvents(context, true);
              return Future.delayed(Duration(milliseconds: 1500));
            },
            onLoadMore: () {
              viewModel.refreshEvents(context, false);
            },
            buildItem: (BuildContext context, HomeArticle data, int index) {
              return HomeArticleWidget(article: data);
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
