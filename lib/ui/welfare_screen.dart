import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/welfare_bean.dart';
import 'package:flutter_wanandroid_redux/model/welfare_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/welfare_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/widget/grid_load_more_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:redux/redux.dart';

import 'image_preview_screen.dart';

class WelfareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welfare"),
      ),
      body: StoreConnector<AppState, WelfareViewModel>(
        onInit: (store) {
          store.dispatch(requestWelfare(true));
        },
        converter: (Store<AppState> store) => WelfareViewModel.fromStore(store),
        builder: (BuildContext context, viewModel) {
          return LoadingView(
            status: viewModel.status,
            errorContent: LoadErrorWidget(),
            loadingContent: LoadingWidget(),
            emptyContent: LoadEmptyWidget(),
            successContent: _buildSuccessContent(context, viewModel),
          );
        },
      ),
    );
  }

  Widget _buildSuccessContent(
      BuildContext context, WelfareViewModel viewModel) {
    return GridLoadMoreWidget(
      isLoading: viewModel.isLoading,
      hasMoreData: viewModel.hasMoreData,
      dataList: viewModel.dataList,
      onLoadMore: () {
        viewModel.refreshEvents(false);
      },
      refreshData: () {
        viewModel.refreshEvents(true);
        return Future.delayed(Duration(milliseconds: 1000));
      },
      gridGap: 4,
      crossAxisCount: 2,
      headerWidget: null,
      buildItem: (BuildContext context, dynamic data, int index) {
        return _buildWelfareItem(context, data, viewModel, index);
      },
    );
  }

  Widget _buildWelfareItem(BuildContext context, WelfareData data,
      WelfareViewModel viewModel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ImagePreviewScreen(
                  welfareList: viewModel.dataList,
                  position: index,
                )));
      },
      child: Hero(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          image: data.url,
          placeholder: "assets/images/image03.jpg",
        ),
        tag: data.url,
      ),
    );
  }
}
