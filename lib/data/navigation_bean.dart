import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';

class NavigationBean {
  List<NavigationData> data;
  int errorCode;
  String errorMsg;

  NavigationBean({this.data, this.errorCode, this.errorMsg});

  NavigationBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<NavigationData>();
      json['data'].forEach((v) {
        data.add(new NavigationData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class NavigationData {
  List<HomeArticle> articles;
  int cid;
  String name;

  NavigationData({this.articles, this.cid, this.name});

  NavigationData.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<HomeArticle>();
      json['articles'].forEach((v) {
        articles.add(new HomeArticle.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    data['cid'] = this.cid;
    data['name'] = this.name;
    return data;
  }
}
