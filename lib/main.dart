import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/redux/store.dart';
import 'package:flutter_wanandroid_redux/ui/splash_screen.dart';
import 'package:redux/redux.dart';

void main() async {
  await WanAndroidApi.getInstance().init();
  runApp(WanAndroidApp(createStore()));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WanAndroidApp extends StatefulWidget {
  final Store<AppState> store;
  WanAndroidApp(this.store);

  @override
  State<StatefulWidget> createState() => _WanAndroidAppState();
}

class _WanAndroidAppState extends State<WanAndroidApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // navigatorKey: navigatorKey,
        title: 'Wan Android',
        theme: ThemeData.dark().copyWith(
          textTheme:
              ThemeData.dark().textTheme.apply(fontFamily: "Source Code Pro"),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
