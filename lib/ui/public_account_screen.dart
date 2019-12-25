import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/public_account_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/public_account_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/account_detail_screen.dart';
import 'package:redux/redux.dart';

class PublicAccountScreen extends StatefulWidget {
  @override
  _PublicAccountScreenState createState() => _PublicAccountScreenState();
}

class _PublicAccountScreenState extends State<PublicAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Public Account")),
      body: StoreConnector<AppState, PublicAccountViewModel>(
        onInit: (store) => store.dispatch(requestAccountTitle()),
        converter: (Store store) => PublicAccountViewModel.fromStore(store),
        builder: (BuildContext context, PublicAccountViewModel viewModel) {
          return DefaultTabController(
            length: viewModel.accountTitles.length,
            child: Column(
              children: <Widget>[
                _buildAccountTitle(viewModel),
                _buildContent(viewModel)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(PublicAccountViewModel viewModel) {
    return Expanded(
        child: TabBarView(
            children: viewModel.accountTitles
                .map((title) => AccountDetailScreen(titleId: title.id))
                .toList()));
  }

  Widget _buildAccountTitle(PublicAccountViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x55000000),
          blurRadius: 0.0,
          spreadRadius: 0.0,
          offset: Offset(1.0, 0.0),
        ),
      ]),
      child: TabBar(
        isScrollable: true,
        labelStyle: TextStyle(fontSize: 16.0),
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        tabs: viewModel.accountTitles.map((title) => Text(title.name)).toList(),
      ),
    );
  }
}
