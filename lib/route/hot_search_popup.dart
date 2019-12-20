import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';
import 'package:flutter_wanandroid_redux/model/pre_search_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/pre_search_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/ui/search_result_screen.dart';
import 'package:flutter_wanandroid_redux/widget/search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class HotSearchPopup extends PopupRoute {
  final positionTween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );

  @override
  Color get barrierColor => Colors.black45;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => "Hello";

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final topPadding = MediaQuery.of(context).padding.top;
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: CircularRevealAnimation(
        animation: curve,
        child: child,
        centerOffset: Offset(size.width - 30, kToolbarHeight / 2),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return StoreConnector<AppState, PreSearchModel>(
      onInit: (store) {
        store.dispatch(requestHotSearchKeys());
      },
      converter: (Store store) => PreSearchModel.fromStore(store),
      builder: (BuildContext context, PreSearchModel viewModel) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              _buildContent(context, viewModel),
              _buildBlankWidget(context)
            ],
          ),
        );
      },
    );
  }

  void _navigateToSearchResult(BuildContext context, String queryText) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            SerachResultScreen(queryText: queryText)));
  }

  Expanded _buildBlankWidget(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(color: Colors.black38),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PreSearchModel viewModel) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchBar(
              showClose: false,
              autofocus: true,
              onSearch: (text) {
                _navigateToSearchResult(context, text);
              }),
          _buildHotKeyLayout(context, viewModel),
          _buildSearchHistoryLayout(context, viewModel)
        ],
      ),
    );
  }

  Widget _buildHotKeyLayout(BuildContext context, PreSearchModel viewModel) {
    List<HotSearch> hotKeyList = viewModel.hotKeyList;
    return (hotKeyList == null || hotKeyList.isEmpty)
        ? Container()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Hot Search",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none)),
                SizedBox(height: 8.0),
                Wrap(
                    spacing: 8.0,
                    children: hotKeyList
                        .map((hotkey) =>
                            _buildHotKeyWidget(context, hotkey.name))
                        .toList())
              ],
            ),
          );
  }

  Widget _buildHotKeyWidget(BuildContext context, String name) {
    return Material(
      color: Colors.transparent,
      child: RawChip(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        label: Text(name),
        onPressed: () {
          _navigateToSearchResult(context, name);
        },
      ),
    );
  }

  Widget _buildSearchHistoryLayout(
      BuildContext context, PreSearchModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Search History",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none)),
              _buildClearWidget()
            ],
          ),
          Material(
            color: Colors.transparent,
            child: RawChip(
              onPressed: () {},
              label: Text("Hello"),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              deleteIcon: Icon(Icons.close, size: 18),
              onDeleted: () {
                Fluttertoast.showToast(msg: "delete");
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildClearWidget() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(3.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.delete, size: 16, color: Colors.white54),
              SizedBox(width: 4.0),
              Text("clear history",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
