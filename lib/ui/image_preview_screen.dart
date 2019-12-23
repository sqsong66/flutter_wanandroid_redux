import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/welfare_bean.dart';
import 'package:flutter_wanandroid_redux/widget/common_toolbar_widget.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatefulWidget {
  final int position;
  final List<WelfareData> welfareList;

  const ImagePreviewScreen(
      {Key key, @required this.position, @required this.welfareList})
      : super(key: key);

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.position;
    _pageController = PageController(initialPage: widget.position);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = "${_currentPage + 1}/${widget.welfareList.length}";
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: widget.welfareList.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: PhotoView(
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.welfareList[index].url),
                imageProvider: NetworkImage(widget.welfareList[index].url),
              ),
            );
          },
        ),
        CommonToolbarWidget(title)
      ],
    );
  }
}
