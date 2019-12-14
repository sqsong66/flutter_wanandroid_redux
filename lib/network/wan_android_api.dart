import 'dart:io';

import 'package:alice/alice.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/data/base_data.dart';
import 'package:flutter_wanandroid_redux/data/home_article_bean.dart';
import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/main.dart';
import 'package:flutter_wanandroid_redux/network/url_constants.dart';
import 'package:path_provider/path_provider.dart';

class WanAndroidApi {
  Dio _dio;
  PersistCookieJar _cookieJar;
  static final WanAndroidApi _instance = WanAndroidApi._internal();

  WanAndroidApi._internal();

  Future<void> init() async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.contentType = "application/x-www-form-urlencoded";
    Alice alice = Alice(showNotification: true, navigatorKey: navigatorKey);
    _dio.interceptors.add(alice.getDioInterceptor());

    Directory dir = await getTemporaryDirectory();
    String cookPath = dir.path;
    _cookieJar = PersistCookieJar(dir: cookPath + "/.cookies/");
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  factory WanAndroidApi.getInstance() {
    return _instance;
  }

  void clearCookies() {
    _cookieJar?.deleteAll();
  }

  String getLoginUserName() {
    List<Cookie> cookies = loadCookies();
    if (cookies != null && cookies.isNotEmpty) {
      for (int i=0; i< cookies.length; i++) {
        var cookie = cookies[i];
        if (cookie.name == "loginUserName") {
          return cookie.value;
        }
      }
    }
    return null;
  }

  List<Cookie> loadCookies() {
    Uri uri = Uri.https(
        "www.wanandroid.com", "https://www.wanandroid.com/user/login");
    return _cookieJar.loadForRequest(uri);
  }

  Future<LoginResult> login(String account, String password) async {
    print("account: $account, password: $password");
    Response response = await _dio
        .post(loginUrl, data: {"username": account, "password": password});
    print("Request result: ${response.data.toString()}");
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }

  Future<List<BannerData>> getBannerList() async {
    Response response = await _dio.get(bannerUrl);
    BannerBean bean = BannerBean.fromJson(response.data);
    if (bean.errorCode == 0 && bean.data != null && bean.data.isNotEmpty) {
      return bean.data;
    }
    return null;
  }

  Future<HomeArticleBean> getHomeArticles(int page) async {
    Response response = await _dio.get("/article/list/$page/json");
    return HomeArticleBean.fromJson(response.data);
  }

  Future<BaseData> collectArticle(int articleId, bool isCollect) async {
    String url = "";
    if (isCollect) {
      url = "/lg/collect/$articleId/json";
    } else {
      url = "/lg/uncollect_originId/$articleId/json";
    }
    Response response = await _dio.post(url);
    return BaseData.fromJson(response.data);
  }

  Future<ProjectClassifyBean> requestProjectClassify() async {
    Response response = await _dio.get(projectClassifyUrl);
    return ProjectClassifyBean.fromJson(response.data);
  }

  Future<HomeArticleBean> requestProjectData(int page, int classifyId) async {
    String url = "/project/list/$page/json";
    Response response =
        await _dio.get(url, queryParameters: {"cid": classifyId});
    return HomeArticleBean.fromJson(response.data);
  }
}
