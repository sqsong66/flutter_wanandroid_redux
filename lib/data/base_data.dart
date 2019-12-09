class BaseData {
  Object data;
  int errorCode;
  String errorMsg;

  BaseData({this.data, this.errorCode, this.errorMsg});

  BaseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Object() : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = null;
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}
