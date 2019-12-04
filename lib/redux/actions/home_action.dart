import 'package:flutter_wanandroid_redux/data/banner_data.dart';
import 'package:flutter_wanandroid_redux/network/wan_android_api.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction refreshBannerData() {
  return (Store store) async {
    List<BannerData> bannerList = await WanAndroidApi().getBannerList();
    if (bannerList == null) {
      bannerList = [];
    }
    store.dispatch(HomeBannerUpdated(bannerList: bannerList));
  };
}

class RefreshHomeBannerAction {
  RefreshHomeBannerAction();
}

class HomeBannerUpdated {
  final List<BannerData> bannerList;
  HomeBannerUpdated({this.bannerList});
}

class RefreshHomeArticleAction {
  final int currentPage;
  RefreshHomeArticleAction({this.currentPage});
}
