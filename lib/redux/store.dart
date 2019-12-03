import 'package:flutter_wanandroid_redux/redux/reducer/app_reducer.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> createStore() {
  return Store(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
}
