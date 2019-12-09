import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/widget/circle_ripple_widget.dart';

class ProjectItemWidget extends StatelessWidget {
  final HomeArticle article;

  ProjectItemWidget({this.article});

  @override
  Widget build(BuildContext context) {
    Widget _leftImage() {
      return SizedBox(
        width: 120.0,
        height: 180.0,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
          child: Image(
              image: AssetImage("assets/images/image01.jpg"),
              fit: BoxFit.cover),
        ),
      );
    }

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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _leftImage(),
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle, size: 18.0, color: Colors.white60,),
                          SizedBox(width: 8.0),
                          Text("Hongyang", style: TextStyle(fontSize: 14.0, color: Colors.white60))
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.access_time, size: 18.0, color: Colors.white60),
                          SizedBox(width: 8.0),
                          Text("2019-11-07 10:43", style: TextStyle(fontSize: 14.0, color: Colors.white60))
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 8.0,
                  top: 8.0,
                  child: CircleRippleWidget(
                    onClick: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Row(
//   children: <Widget>[
//     Icon(Icons.account_circle, size: 20.0),
//     SizedBox(width: 8.0),
//     Text("Hongyang", style: TextStyle(fontSize: 14.0))
//   ],
// )
