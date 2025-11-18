class UsersResponseModel {
  UsersResponseModel({
      num? total, 
      num? offset, 
      num? limit, 
      num? returned, 
      List<UsersData>? data,}){
    _total = total;
    _offset = offset;
    _limit = limit;
    _returned = returned;
    _data = data;
}

  UsersResponseModel.fromJson(dynamic json) {
    _total = json['total'];
    _offset = json['offset'];
    _limit = json['limit'];
    _returned = json['returned'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UsersData.fromJson(v));
      });
    }
  }
  num? _total;
  num? _offset;
  num? _limit;
  num? _returned;
  List<UsersData>? _data;
UsersResponseModel copyWith({  num? total,
  num? offset,
  num? limit,
  num? returned,
  List<UsersData>? data,
}) => UsersResponseModel(  total: total ?? _total,
  offset: offset ?? _offset,
  limit: limit ?? _limit,
  returned: returned ?? _returned,
  data: data ?? _data,
);
  num? get total => _total;
  num? get offset => _offset;
  num? get limit => _limit;
  num? get returned => _returned;
  List<UsersData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['offset'] = _offset;
    map['limit'] = _limit;
    map['returned'] = _returned;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UsersData {
  UsersData({
      num? id, 
      String? name, 
      String? mobileNo, 
      String? email, 
      num? roleId, 
      String? stateName, 
      String? roleName, 
      String? status,}){
    _id = id;
    _name = name;
    _mobileNo = mobileNo;
    _email = email;
    _roleId = roleId;
    _stateName = stateName;
    _roleName = roleName;
    _status = status;
}

  UsersData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobileNo = json['mobile_no'];
    _email = json['email'];
    _roleId = json['role_id'];
    _stateName = json['state_name'];
    _roleName = json['role_name'];
    _status = json['status'];
  }
  num? _id;
  String? _name;
  String? _mobileNo;
  String? _email;
  num? _roleId;
  String? _stateName;
  String? _roleName;
  String? _status;
  UsersData copyWith({  num? id,
  String? name,
  String? mobileNo,
  String? email,
  num? roleId,
  String? stateName,
  String? roleName,
  String? status,
}) => UsersData(  id: id ?? _id,
  name: name ?? _name,
  mobileNo: mobileNo ?? _mobileNo,
  email: email ?? _email,
  roleId: roleId ?? _roleId,
  stateName: stateName ?? _stateName,
  roleName: roleName ?? _roleName,
  status: status ?? _status,
);
  num? get id => _id;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get email => _email;
  num? get roleId => _roleId;
  String? get stateName => _stateName;
  String? get roleName => _roleName;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile_no'] = _mobileNo;
    map['email'] = _email;
    map['role_id'] = _roleId;
    map['state_name'] = _stateName;
    map['role_name'] = _roleName;
    map['status'] = _status;
    return map;
  }

}