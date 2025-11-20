class LocationModelResponse {
  LocationModelResponse({
      num? userId, 
      String? mobileNo, 
      num? primaryLocationId, 
      num? intransitLocationId,}){
    _userId = userId;
    _mobileNo = mobileNo;
    _primaryLocationId = primaryLocationId;
    _intransitLocationId = intransitLocationId;
}

  LocationModelResponse.fromJson(dynamic json) {
    _userId = json['user_id'];
    _mobileNo = json['mobile_no'];
    _primaryLocationId = json['primary_location_id'];
    _intransitLocationId = json['intransit_location_id'];
  }
  num? _userId;
  String? _mobileNo;
  num? _primaryLocationId;
  num? _intransitLocationId;
LocationModelResponse copyWith({  num? userId,
  String? mobileNo,
  num? primaryLocationId,
  num? intransitLocationId,
}) => LocationModelResponse(  userId: userId ?? _userId,
  mobileNo: mobileNo ?? _mobileNo,
  primaryLocationId: primaryLocationId ?? _primaryLocationId,
  intransitLocationId: intransitLocationId ?? _intransitLocationId,
);
  num? get userId => _userId;
  String? get mobileNo => _mobileNo;
  num? get primaryLocationId => _primaryLocationId;
  num? get intransitLocationId => _intransitLocationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['mobile_no'] = _mobileNo;
    map['primary_location_id'] = _primaryLocationId;
    map['intransit_location_id'] = _intransitLocationId;
    return map;
  }

}