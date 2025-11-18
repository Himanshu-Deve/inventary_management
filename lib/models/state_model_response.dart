class StateModelResponse {
  StateModelResponse({
      num? total, 
      num? offset, 
      num? limit, 
      num? returned, 
      List<Data>? data,}){
    _total = total;
    _offset = offset;
    _limit = limit;
    _returned = returned;
    _data = data;
}

  StateModelResponse.fromJson(dynamic json) {
    _total = json['total'];
    _offset = json['offset'];
    _limit = json['limit'];
    _returned = json['returned'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _total;
  num? _offset;
  num? _limit;
  num? _returned;
  List<Data>? _data;
StateModelResponse copyWith({  num? total,
  num? offset,
  num? limit,
  num? returned,
  List<Data>? data,
}) => StateModelResponse(  total: total ?? _total,
  offset: offset ?? _offset,
  limit: limit ?? _limit,
  returned: returned ?? _returned,
  data: data ?? _data,
);
  num? get total => _total;
  num? get offset => _offset;
  num? get limit => _limit;
  num? get returned => _returned;
  List<Data>? get data => _data;

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

class Data {
  Data({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Data copyWith({  num? id,
  String? name,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}