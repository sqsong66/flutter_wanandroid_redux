import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestHotSearchKeys() {
  return (Store<AppState> store) async {
    HotSearchKeyBean bean =
        await WanAndroidApi.getInstance().requestHotSearchKey();
    if (bean.errorCode == 0) {
      store.dispatch(UpdateHotKeyAction(hotKeyList: bean.data));
    }
  };
}

class UpdateHotKeyAction {
  final List<HotSearch> hotKeyList;
  // final List<String> historyList;
  UpdateHotKeyAction({this.hotKeyList});
}
