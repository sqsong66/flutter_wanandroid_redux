import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:preload_page_view/preload_page_view.dart';

const TOTAL_PAGES = 100000;

class BannerWidget extends StatefulWidget {
  final double bannerHeight;
  final List<BannerData> bannerLists;

  BannerWidget({@required this.bannerLists, this.bannerHeight});

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> with AutomaticKeepAliveClientMixin<BannerWidget> {
  Timer _timer;
  int _currentIndex = 0;
  PreloadPageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  void _initController() {
    if (_pageController == null &&
        widget.bannerLists != null &&
        widget.bannerLists.isNotEmpty) {
      double initPage =
          TOTAL_PAGES / 2 - (TOTAL_PAGES / 2) % widget.bannerLists.length;
      _pageController = PreloadPageController(initialPage: initPage.toInt());
      _initTimer();
    }
  }

  void _initTimer() {
    stopTimer();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int newPage = _pageController.page.toInt() + 1;
      if (newPage >= TOTAL_PAGES) {
        newPage = 0;
      }
      _pageController.animateToPage(
        newPage,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 300),
      );
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
    stopTimer();
  }

  Widget _placeHolder() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image(
          image: AssetImage("assets/images/horizontal_placeholder.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _banner() {
    return PreloadPageView.builder(
      controller: _pageController,
      itemCount: TOTAL_PAGES,
      preloadPagesCount: 3,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index % widget.bannerLists.length;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  image: NetworkImage(widget
                      .bannerLists[index % widget.bannerLists.length]
                      .imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bannerWidget() {
    return Stack(
      children: <Widget>[
        _banner(),
        Indicator(
          widget.bannerLists.length,
          currentIndex: _currentIndex,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _initController();
    return Container(
      height: (widget.bannerHeight == 0) ? 220.0 : widget.bannerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0x33000000),
              blurRadius: 3.0,
              spreadRadius: 0.5,
              offset: Offset(3.0, 3.0),
            ),
          ]),
      child: (widget.bannerLists == null || widget.bannerLists.length == 0)
          ? _placeHolder()
          : _bannerWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Indicator extends StatelessWidget {
  final int totalSize;
  final int currentIndex;
  final double size;
  final Color normalColor;
  final Color selectedColor;
  final double bottomMargin;
  final double dotGap;

  Indicator(this.totalSize,
      {this.currentIndex = 0,
      this.size = 6.5,
      this.normalColor = Colors.black54,
      this.selectedColor = Colors.white,
      this.bottomMargin = 20.0,
      this.dotGap = 10.0});

  List<Widget> _dotList() {
    List<Widget> dotList = [];
    for (var i = 0; i < totalSize; i++) {
      dotList.add(Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(right: dotGap),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == i ? selectedColor : normalColor),
      ));
    }
    return dotList;
  }

  @override
  Widget build(BuildContext context) {
    return totalSize <= 0
        ? Container()
        : Positioned(
            bottom: bottomMargin,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _dotList(),
            ),
          );
  }
}
