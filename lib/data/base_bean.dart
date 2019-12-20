abstract class BaseBean<T> {
  int errorCode;
  String errorMsg;
  T data;

  BaseBean({this.errorCode, this.errorMsg, this.data});
}
