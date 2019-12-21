import 'package:flutter_wanandroid_redux/data/hot_search_key_bean.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/utils/common_utils.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestHotSearchKeys() {
  return (Store<AppState> store) async {
    HotSearchKeyBean bean =
        await WanAndroidApi.getInstance().requestHotSearchKey();
    if (bean.errorCode == 0) {
      List<String> historyList = await CommonUtils.loadSearchKeyWords();
      store.dispatch(
          UpdateHotKeyAction(hotKeyList: bean.data, historyList: historyList));
    }
  };
}

ThunkAction<AppState> deleteSearchKey(String keyWord, bool isClear) {
  return (Store<AppState> store) async {
    List<String> historyList =
        await CommonUtils.deleteSearchKey(keyWord, isClear);
    var hotKeyList = store.state.searchActionState.hotKeyList;
    store.dispatch(
        UpdateHotKeyAction(hotKeyList: hotKeyList, historyList: historyList));
  };
}

class UpdateHotKeyAction {
  final List<HotSearch> hotKeyList;
  final List<String> historyList;
  UpdateHotKeyAction({this.hotKeyList, this.historyList});
}
