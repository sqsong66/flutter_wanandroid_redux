import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/search_result_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/widget/load_empty_widget.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:flutter_wanandroid_redux/widget/search_bar.dart';
import 'package:redux/redux.dart';

class SerachResultScreen extends StatelessWidget {
  final String queryText;

  SerachResultScreen({this.queryText});

  PreferredSizeWidget _buildSearchBar(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + topPadding),
      child: Column(
        children: <Widget>[
          Container(
              height: topPadding, color: Theme.of(context).primaryColorDark),
          SearchBar(
            showClose: true,
            autofocus: false,
            defaultText: queryText,
            onSearch: (text) {},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchResultViewModel>(
      converter: (Store store) => SearchResultViewModel.fromStore(store),
      builder: (BuildContext context, SearchResultViewModel viewModel) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildSearchBar(context),
          body: LoadingView(
              status: viewModel.status,
              errorContent: LoadErrorWidget(),
              loadingContent: LoadingWidget(),
              emptyContent: LoadEmptyWidget(),
              successContent: Container()),
        );
      },
    );
  }
}
