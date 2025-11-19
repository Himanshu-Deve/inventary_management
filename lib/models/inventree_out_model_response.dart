class InventreeOutModelResponse {
  InventreeOutModelResponse({
      bool? success, 
      num? transferredCount, 
      num? failedCount, 
      List<String>? failedSerials, 
      InventreeResponse? inventreeResponse,}){
    _success = success;
    _transferredCount = transferredCount;
    _failedCount = failedCount;
    _failedSerials = failedSerials;
    _inventreeResponse = inventreeResponse;
}

  InventreeOutModelResponse.fromJson(dynamic json) {
    _success = json['success'];
    _transferredCount = json['transferred_count'];
    _failedCount = json['failed_count'];
    _failedSerials = json['failed_serials'] != null ? json['failed_serials'].cast<String>() : [];
    _inventreeResponse = json['inventree_response'] != null ? InventreeResponse.fromJson(json['inventree_response']) : null;
  }
  bool? _success;
  num? _transferredCount;
  num? _failedCount;
  List<String>? _failedSerials;
  InventreeResponse? _inventreeResponse;
InventreeOutModelResponse copyWith({  bool? success,
  num? transferredCount,
  num? failedCount,
  List<String>? failedSerials,
  InventreeResponse? inventreeResponse,
}) => InventreeOutModelResponse(  success: success ?? _success,
  transferredCount: transferredCount ?? _transferredCount,
  failedCount: failedCount ?? _failedCount,
  failedSerials: failedSerials ?? _failedSerials,
  inventreeResponse: inventreeResponse ?? _inventreeResponse,
);
  bool? get success => _success;
  num? get transferredCount => _transferredCount;
  num? get failedCount => _failedCount;
  List<String>? get failedSerials => _failedSerials;
  InventreeResponse? get inventreeResponse => _inventreeResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['transferred_count'] = _transferredCount;
    map['failed_count'] = _failedCount;
    map['failed_serials'] = _failedSerials;
    if (_inventreeResponse != null) {
      map['inventree_response'] = _inventreeResponse?.toJson();
    }
    return map;
  }

}

class InventreeResponse {
  InventreeResponse({
      List<Items>? items, 
      String? notes, 
      num? location,}){
    _items = items;
    _notes = notes;
    _location = location;
}

  InventreeResponse.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _notes = json['notes'];
    _location = json['location'];
  }
  List<Items>? _items;
  String? _notes;
  num? _location;
InventreeResponse copyWith({  List<Items>? items,
  String? notes,
  num? location,
}) => InventreeResponse(  items: items ?? _items,
  notes: notes ?? _notes,
  location: location ?? _location,
);
  List<Items>? get items => _items;
  String? get notes => _notes;
  num? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['notes'] = _notes;
    map['location'] = _location;
    return map;
  }

}

class Items {
  Items({
      num? pk, 
      String? quantity, 
      num? status,}){
    _pk = pk;
    _quantity = quantity;
    _status = status;
}

  Items.fromJson(dynamic json) {
    _pk = json['pk'];
    _quantity = json['quantity'];
    _status = json['status'];
  }
  num? _pk;
  String? _quantity;
  num? _status;
Items copyWith({  num? pk,
  String? quantity,
  num? status,
}) => Items(  pk: pk ?? _pk,
  quantity: quantity ?? _quantity,
  status: status ?? _status,
);
  num? get pk => _pk;
  String? get quantity => _quantity;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pk'] = _pk;
    map['quantity'] = _quantity;
    map['status'] = _status;
    return map;
  }

}