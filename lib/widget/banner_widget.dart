import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:preload_page_view/preload_page_view.dart';

class BannerWidget extends StatefulWidget {
  final List<BannerData> imageLists;

  BannerWidget({this.imageLists});

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;
  double _bannerHeight = 200.0;
  PreloadPageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
      itemCount: widget.imageLists.length,
      preloadPagesCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  image: AssetImage(widget.imageLists[index]
                      .imagePath), // NetworkImage(widget.imageLists[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bannerHeight,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: (widget.imageLists == null || widget.imageLists.length == 0)
          ? _placeHolder()
          : Stack(
            children: <Widget>[
              _banner()
            ],
          ),
    );
  }
}
