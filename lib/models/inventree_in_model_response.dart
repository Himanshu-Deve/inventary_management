    class InventreeInModelResponse {
      InventreeInModelResponse({
          List<Results>? results,}){
        _results = results;
    }

      InventreeInModelResponse.fromJson(dynamic json) {
        if (json['results'] != null) {
          _results = [];
          json['results'].forEach((v) {
            _results?.add(Results.fromJson(v));
          });
        }
      }
      List<Results>? _results;
    InventreeInModelResponse copyWith({  List<Results>? results,
    }) => InventreeInModelResponse(  results: results ?? _results,
    );
      List<Results>? get results => _results;

      Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        if (_results != null) {
          map['results'] = _results?.map((v) => v.toJson()).toList();
        }
        return map;
      }

    }

    class Results {
      Results({
          Input? input,
          Response? response,
          num? status,}){
        _input = input;
        _response = response;
        _status = status;
    }

      Results.fromJson(dynamic json) {
        _input = json['input'] != null ? Input.fromJson(json['input']) : null;
        _response = json['response'] != null ? Response.fromJson(json['response']) : null;
        _status = json['status'];
      }
      Input? _input;
      Response? _response;
      num? _status;
    Results copyWith({  Input? input,
      Response? response,
      num? status,
    }) => Results(  input: input ?? _input,
      response: response ?? _response,
      status: status ?? _status,
    );
      Input? get input => _input;
      Response? get response => _response;
      num? get status => _status;

      Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        if (_input != null) {
          map['input'] = _input?.toJson();
        }
        if (_response != null) {
          map['response'] = _response?.toJson();
        }
        map['status'] = _status;
        return map;
      }

    }

    class Response {
      Response({
          List<String>? serial,}){
        _serial = serial;
    }

      Response.fromJson(dynamic json) {
        _serial = json['serial'] != null ? json['serial'].cast<String>() : [];
      }
      List<String>? _serial;
    Response copyWith({  List<String>? serial,
    }) => Response(  serial: serial ?? _serial,
    );
      List<String>? get serial => _serial;

      Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        map['serial'] = _serial;
        return map;
      }

    }

    class Input {
      Input({
          num? part,
          num? quantity,
          String? serial,
          String? batch,
          num? location,
          String? notes,
          num? status,
          String? purchasePrice,
          String? purchasePriceCurrency,
          String? barcodeData,
          String? barcodeHash,}){
        _part = part;
        _quantity = quantity;
        _serial = serial;
        _batch = batch;
        _location = location;
        _notes = notes;
        _status = status;
        _purchasePrice = purchasePrice;
        _purchasePriceCurrency = purchasePriceCurrency;
        _barcodeData = barcodeData;
        _barcodeHash = barcodeHash;
    }

      Input.fromJson(dynamic json) {
        _part = json['part'];
        _quantity = json['quantity'];
        _serial = json['serial'];
        _batch = json['batch'];
        _location = json['location'];
        _notes = json['notes'];
        _status = json['status'];
        _purchasePrice = json['purchase_price'];
        _purchasePriceCurrency = json['purchase_price_currency'];
        _barcodeData = json['barcode_data'];
        _barcodeHash = json['barcode_hash'];
      }
      num? _part;
      num? _quantity;
      String? _serial;
      String? _batch;
      num? _location;
      String? _notes;
      num? _status;
      String? _purchasePrice;
      String? _purchasePriceCurrency;
      String? _barcodeData;
      String? _barcodeHash;
    Input copyWith({  num? part,
      num? quantity,
      String? serial,
      String? batch,
      num? location,
      String? notes,
      num? status,
      String? purchasePrice,
      String? purchasePriceCurrency,
      String? barcodeData,
      String? barcodeHash,
    }) => Input(  part: part ?? _part,
      quantity: quantity ?? _quantity,
      serial: serial ?? _serial,
      batch: batch ?? _batch,
      location: location ?? _location,
      notes: notes ?? _notes,
      status: status ?? _status,
      purchasePrice: purchasePrice ?? _purchasePrice,
      purchasePriceCurrency: purchasePriceCurrency ?? _purchasePriceCurrency,
      barcodeData: barcodeData ?? _barcodeData,
      barcodeHash: barcodeHash ?? _barcodeHash,
    );
      num? get part => _part;
      num? get quantity => _quantity;
      String? get serial => _serial;
      String? get batch => _batch;
      num? get location => _location;
      String? get notes => _notes;
      num? get status => _status;
      String? get purchasePrice => _purchasePrice;
      String? get purchasePriceCurrency => _purchasePriceCurrency;
      String? get barcodeData => _barcodeData;
      String? get barcodeHash => _barcodeHash;

      Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        map['part'] = _part;
        map['quantity'] = _quantity;
        map['serial'] = _serial;
        map['batch'] = _batch;
        map['location'] = _location;
        map['notes'] = _notes;
        map['status'] = _status;
        map['purchase_price'] = _purchasePrice;
        map['purchase_price_currency'] = _purchasePriceCurrency;
        map['barcode_data'] = _barcodeData;
        map['barcode_hash'] = _barcodeHash;
        return map;
      }

    }