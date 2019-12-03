import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wanandroid_redux/data/login_result.dart';
import 'package:flutter_wanandroid_redux/main.dart';
import 'package:flutter_wanandroid_redux/network/url_constants.dart';

class WanAndroidApi {
  Dio _dio;
  static final WanAndroidApi _instance = WanAndroidApi._internal();

  WanAndroidApi._internal() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.contentType = "application/x-www-form-urlencoded";
    Alice alice = Alice(showNotification: true, navigatorKey: navigatorKey);
    _dio.interceptors.add(alice.getDioInterceptor());
  }

  factory WanAndroidApi() {
    return _instance;
  }

  Future<LoginResult> login(String account, String password) async {
    print("account: $account, password: $password");
    Response response = await _dio
        .post(loginUrl, data: {"username": account, "password": password});
    print("Request result: ${response.data.toString()}");
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }
}
