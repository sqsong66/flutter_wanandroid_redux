import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/model/home_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/webview_screen.dart';
import 'package:flutter_wanandroid_redux/widget/banner_widget.dart';
import 'package:flutter_wanandroid_redux/widget/circle_ripple_widget.dart';
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

  AppBar _homeAppBar() {
    return AppBar(
      title: Text(
        "Home",
        style: TextStyle(
          fontSize: 22.0,
          fontFamily: "Source Code Pro",
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: CircleRippleWidget(
            icon: Icon(Icons.search, size: 24.0),
            onClick: () {},
          ),
        )
      ],
    );
  }

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
          return Scaffold(
            appBar: _homeAppBar(),
            body: HomeRefreshWidget<HomeArticle>(
              isLoading: viewModel.isLoading,
              hasMoreData: viewModel.hasMoreData,
              dataList: viewModel.articleList,
              headerWidget: BannerWidget(
                bannerLists: viewModel.bannerList,
                bannerHeight: viewModel.bannerHeight,
                bannerClick: (title, link) =>
                    _openWebView(context, title, link),
              ),
              refreshData: () async {
                viewModel.refreshEvents(context, true);
                return Future.delayed(Duration(milliseconds: 1500));
              },
              onLoadMore: () {
                viewModel.refreshEvents(context, false);
              },
              buildItem: (BuildContext context, dynamic data, int index) {
                return data is HomeArticle
                    ? HomeArticleWidget(
                        article: data,
                        onItemClick: (title, link) =>
                            _openWebView(context, title, link),
                        onShare: (link) {
                          Share.text('Share', link, 'text/plain');
                        },
                        onStar: (article) {},
                      )
                    : Container();
              },
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
