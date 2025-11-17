class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      bool? success, 
      num? code, 
      Data? data, 
      String? message,}){
    _success = success;
    _code = code;
    _data = data;
    _message = message;
}

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  num? _code;
  Data? _data;
  String? _message;
VerifyOtpResponseModel copyWith({  bool? success,
  num? code,
  Data? data,
  String? message,
}) => VerifyOtpResponseModel(  success: success ?? _success,
  code: code ?? _code,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  num? get code => _code;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

class Data {
  Data({
      String? message, 
      String? mobile, 
      bool? isVerified, 
      String? token,}){
    _message = message;
    _mobile = mobile;
    _isVerified = isVerified;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _mobile = json['mobile'];
    _isVerified = json['is_verified'];
    _token = json['token'];
  }
  String? _message;
  String? _mobile;
  bool? _isVerified;
  String? _token;
Data copyWith({  String? message,
  String? mobile,
  bool? isVerified,
  String? token,
}) => Data(  message: message ?? _message,
  mobile: mobile ?? _mobile,
  isVerified: isVerified ?? _isVerified,
  token: token ?? _token,
);
  String? get message => _message;
  String? get mobile => _mobile;
  bool? get isVerified => _isVerified;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['mobile'] = _mobile;
    map['is_verified'] = _isVerified;
    map['token'] = _token;
    return map;
  }

}