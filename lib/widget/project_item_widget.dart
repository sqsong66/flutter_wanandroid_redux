import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/widget/circle_ripple_widget.dart';

class ProjectItemWidget extends StatelessWidget {
  final HomeArticle article;
  final Function(HomeArticle) onStar;
  final Function(String, String) onItemClick;

  ProjectItemWidget({this.article, this.onStar, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _leftImage(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _buildRightWidgets(),
                    _collectWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftImage() {
    return SizedBox(
      width: 120.0,
      height: 180.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
        child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            image: article.envelopePic,
            placeholder:
                "assets/images/image03.jpg"), // horizontal_placeholder.jpg
      ),
    );
  }

  Padding _buildRightWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            article.title,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            article.desc,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 16.0,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 8.0),
                  Text(article.author,
                      style: TextStyle(fontSize: 16.0, color: Colors.white))
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: <Widget>[
                  Icon(Icons.access_time, size: 16.0, color: Colors.white70),
                  SizedBox(width: 8.0),
                  Text(article.niceDate,
                      style: TextStyle(fontSize: 14.0, color: Colors.white))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _collectWidget() {
    return Positioned(
      right: 8.0,
      bottom: 8.0,
      child: CircleRippleWidget(
        onClick: () {
          onStar(article);
        },
        icon: article.collect
            ? Icon(Icons.favorite, color: Colors.redAccent, size: 24.0)
            : Icon(Icons.favorite_border, size: 24.0),
      ),
    );
  }
}
