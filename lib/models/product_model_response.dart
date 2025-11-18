class ProductModelResponse {
  ProductModelResponse({
      num? offset, 
      num? limit, 
      num? count, 
      List<Data>? data,}){
    _offset = offset;
    _limit = limit;
    _count = count;
    _data = data;
}

  ProductModelResponse.fromJson(dynamic json) {
    _offset = json['offset'];
    _limit = json['limit'];
    _count = json['count'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _offset;
  num? _limit;
  num? _count;
  List<Data>? _data;
ProductModelResponse copyWith({  num? offset,
  num? limit,
  num? count,
  List<Data>? data,
}) => ProductModelResponse(  offset: offset ?? _offset,
  limit: limit ?? _limit,
  count: count ?? _count,
  data: data ?? _data,
);
  num? get offset => _offset;
  num? get limit => _limit;
  num? get count => _count;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = _offset;
    map['limit'] = _limit;
    map['count'] = _count;
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