class LocationModelResponse {
  LocationModelResponse({
      num? userId, 
      String? mobileNo, 
      Location? location,}){
    _userId = userId;
    _mobileNo = mobileNo;
    _location = location;
}

  LocationModelResponse.fromJson(dynamic json) {
    _userId = json['user_id'];
    _mobileNo = json['mobile_no'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  num? _userId;
  String? _mobileNo;
  Location? _location;
LocationModelResponse copyWith({  num? userId,
  String? mobileNo,
  Location? location,
}) => LocationModelResponse(  userId: userId ?? _userId,
  mobileNo: mobileNo ?? _mobileNo,
  location: location ?? _location,
);
  num? get userId => _userId;
  String? get mobileNo => _mobileNo;
  Location? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['mobile_no'] = _mobileNo;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }

}

class Location {
  Location({
      num? id, 
      String? pathstring,}){
    _id = id;
    _pathstring = pathstring;
}

  Location.fromJson(dynamic json) {
    _id = json['id'];
    _pathstring = json['pathstring'];
  }
  num? _id;
  String? _pathstring;
Location copyWith({  num? id,
  String? pathstring,
}) => Location(  id: id ?? _id,
  pathstring: pathstring ?? _pathstring,
);
  num? get id => _id;
  String? get pathstring => _pathstring;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pathstring'] = _pathstring;
    return map;
  }

}