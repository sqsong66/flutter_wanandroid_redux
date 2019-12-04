import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';

class UpdateHomeBannerAction {
  UpdateHomeBannerAction();
}

class UpdateHomeArticleAction {
  final List<HomeArticle> articleLists;
  final int currentPage;
  UpdateHomeArticleAction({this.articleLists, this.currentPage});
}
