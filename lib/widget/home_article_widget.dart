import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/utils/common_utils.dart';
import 'package:flutter_wanandroid_redux/widget/circle_ripple_widget.dart';

import 'label_view.dart';

class HomeArticleWidget extends StatelessWidget {
  final HomeArticle article;
  final Function(String, String) onItemClick;
  final Function(String) onShare;
  final Function(HomeArticle) onStar;

  HomeArticleWidget(
      {@required this.article,
      @required this.onItemClick,
      @required this.onShare,
      @required this.onStar});

  Widget _circleTextWidget(BuildContext context, String text) {
    return CircleAvatar(
      radius: 10.0,
      backgroundColor: Theme.of(context).disabledColor,
      child: Text(
        text,
        style: TextStyle(fontSize: 12.0, color: Colors.white),
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 30.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              _circleTextWidget(
                  context,
                  CommonUtils.analysisFirstLetter(
                      article.author, article.shareUser)),
              SizedBox(width: 8.0),
              Text(
                  article.author.isNotEmpty
                      ? article.author
                      : article.shareUser,
                  style: TextStyle(color: Colors.white, fontSize: 14.0))
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.timer, size: 18.0, color: Colors.white60),
              SizedBox(width: 4.0),
              Text(article.niceDate,
                  style: TextStyle(color: Colors.white60, fontSize: 14.0))
            ],
          )
        ],
      ),
    );
  }

  Widget _chapterWiget(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(15.0)),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0x55000000),
              blurRadius: 8.0,
              spreadRadius: 0.5,
              offset: Offset(3.0, 3.0),
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onItemClick(article.title, article.link);
          },
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _topView(context),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   article.title.trim(),
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 18.0,
                          //       wordSpacing: 1.0),
                          // ),
                          Html(
                            data: article.title.trim(),
                            defaultTextStyle:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    article.superChapterName.isEmpty
                                        ? SizedBox()
                                        : _chapterWiget(
                                            context, article.superChapterName),
                                    SizedBox(width: 12.0),
                                    article.chapterName.isEmpty
                                        ? SizedBox()
                                        : _chapterWiget(
                                            context, article.chapterName),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  CircleRippleWidget(
                                    icon: Icon(Icons.share, size: 24.0),
                                    onClick: () {
                                      onShare(article.link);
                                    },
                                  ),
                                  SizedBox(width: 8.0),
                                  CircleRippleWidget(
                                    icon: article.collect
                                        ? Icon(Icons.favorite,
                                            color: Colors
                                                .redAccent, // Theme.of(context).accentColor
                                            size: 24.0)
                                        : Icon(Icons.favorite_border,
                                            size: 24.0),
                                    onClick: () {
                                      onStar(article);
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
              Positioned(
                right: 0.0,
                child: article.fresh
                    ? LabelView(
                        Size(35.0, 35.0),
                        labelText: "New",
                        labelAlignment: LabelAlignment.rightTop,
                        labelColor: Theme.of(context).disabledColor,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
