import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/home_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/home_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/widget/banner_widget.dart';

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
    // List<BannerData> bannerList = [
    //   BannerData(imagePath: "assets/images/image01.jpg"),
    //   BannerData(imagePath: "assets/images/image02.jpg"),
    //   BannerData(imagePath: "assets/images/image03.jpg"),
    //   BannerData(imagePath: "assets/images/image04.jpg"),
    // ];
    // return Column(
    //   children: <Widget>[
    //     BannerWidget(bannerLists: bannerList,)
    //   ],
    // );
    return StoreConnector<AppState, HomeViewModel>(
        onInit: (store) => store.dispatch(refreshBannerData),
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, viewModel) {
          return Column(
            children: <Widget>[
              BannerWidget(bannerLists: viewModel.bannerList),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
