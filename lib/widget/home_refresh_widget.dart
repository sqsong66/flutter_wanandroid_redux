import 'package:flutter/material.dart';

class HomeRefreshWidget<T> extends StatelessWidget {
  final bool isLoading;
  final bool hasMoreData;
  final List<T> dataList;
  final Widget headerWidget;
  final RefreshCallback refreshData;
  final VoidCallback onLoadMore;
  final Function(BuildContext context, T data, int index) buildItem;

  HomeRefreshWidget(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.headerWidget,
      @required this.dataList,
      @required this.refreshData,
      @required this.onLoadMore,
      @required this.buildItem});

  Widget _loadingItemWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: hasMoreData
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
    return Container(
      child: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          itemCount: dataList == null ? 0 : dataList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return headerWidget == null ? Container() : headerWidget;
            } else if (index == dataList.length + 1) {
              return _loadingItemWidget();
            } else {
              return buildItem(context, dataList[index - 1], index - 1);
            }
          },
        ),
      ),
    );
  }
}
