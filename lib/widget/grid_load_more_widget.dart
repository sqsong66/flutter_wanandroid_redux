import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/common/item_builder.dart';

class GridLoadMoreWidget<T> extends StatefulWidget {
  final bool isLoading;
  final bool hasMoreData;
  final List<T> dataList;
  final Widget headerWidget;
  final VoidCallback onLoadMore;
  final RefreshCallback refreshData;
  final ItemBuilder buildItem;
  final int crossAxisCount;
  final double gridGap;

  GridLoadMoreWidget(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.headerWidget,
      @required this.dataList,
      @required this.refreshData,
      @required this.onLoadMore,
      @required this.buildItem,
      @required this.crossAxisCount,
      @required this.gridGap});

  @override
  _GridLoadMoreWidgetState createState() => _GridLoadMoreWidgetState();
}

class _GridLoadMoreWidgetState extends State<GridLoadMoreWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _getMoreData() {
    if (!widget.isLoading && widget.hasMoreData) widget.onLoadMore();
  }

  Widget _loadingItemWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: widget.hasMoreData
          ? _loadingStateWidget()
          : Text("No more data.", style: TextStyle(fontSize: 16.0)),
    );
  }

  Widget _loadingStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
        SizedBox(width: 16.0),
        Text("Loading...", style: TextStyle(fontSize: 16.0))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Padding(
        padding: EdgeInsets.all(widget.gridGap),
        child: CustomScrollView(
          key: _refreshIndicatorKey,
          controller: _scrollController,
          slivers: <Widget>[
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    widget.buildItem(context, widget.dataList[index], index),
                childCount: widget.dataList.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: widget.gridGap,
                  mainAxisSpacing: widget.gridGap,
                  childAspectRatio: 4 / 5),
            ),
            SliverToBoxAdapter(
              child: _loadingItemWidget(),
            )
          ],
        ),
      ),
      onRefresh: widget.refreshData,
    );
  }
}
