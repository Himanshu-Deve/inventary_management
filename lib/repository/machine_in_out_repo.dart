import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:inventory_management/models/inventree_in_model_response.dart';
import 'package:inventory_management/models/inventree_out_model_response.dart';
import 'package:inventory_management/models/location_model_response.dart';
import 'package:inventory_management/models/product_model_response.dart';
import 'package:inventory_management/models/state_model_response.dart';
import 'package:inventory_management/models/users_response_model.dart';
import 'package:inventory_management/repository/api_client.dart';
import 'package:inventory_management/utils/app_utils.dart';

class MachineInOutRepo {
  final Dio _dio = ApiClient.dio;

  /// Fetch Product List
  Future<ProductModelResponse> productApi() async {
    try {
      final headers = _dio.options.headers.map(
            (key, value) => MapEntry(key, value.toString()),
      );

      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/parts/?offset=0&limit=30',
        {},
        headers,
      );

      final res = await _dio.get('/inventree/parts/?offset=0&limit=30');

      AppUtils.showSuccess("Data Fetched Successfully!");

      return ProductModelResponse.fromJson(res.data);

    } on DioError catch (e) {
      final errorMessage = _handleDioError(e);
      AppUtils.showError(errorMessage);
      throw Exception(errorMessage);        // Required since return type is model
    } catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }

 Future<StateModelResponse> stateApi(int page) async {
    try {
      final headers = _dio.options.headers.map(
            (key, value) => MapEntry(key, value.toString()),
      );

      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/states/?offset=$page&limit=10',
        {},
        headers,
      );

      final res = await _dio.get('/inventree/states/?offset=$page&limit=10');

      return StateModelResponse.fromJson(res.data);

    } on DioError catch (e) {
      final errorMessage = _handleDioError(e);
      AppUtils.showError(errorMessage);
      throw Exception(errorMessage);
    } catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<UsersResponseModel> usersApi({
    int page = 0,
    int? state,
    String query = "",
  }) async {
    try {
      final headers = _dio.options.headers.map(
            (key, value) => MapEntry(key, value.toString()),
      );


      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/users/?state_id=$state&offset=$page&limit=1000',
        {},
        headers,
      );

      final res = await _dio.get(
          state!=null?'/inventree/users/?state_id=$state&offset=$page&limit=1000':'/inventree/users/?offset=$page&limit=1000'
      );

      AppUtils.showSuccess("User Fetched Successfully!");

      return UsersResponseModel.fromJson(res.data);
    }
    on DioError catch (e) {
      final errorMessage = _handleDioError(e);
      AppUtils.showError(errorMessage);
      throw Exception(errorMessage);
    }
    catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<LocationModelResponse> getUserLocations({
    required int userId,
  }) async {
    try {
      final headers = _dio.options.headers.map(
            (key, value) => MapEntry(key, value.toString()),
      );

      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/user/$userId/location/',
        {},
        headers,
      );

      final response = await _dio.get(
        '/inventree/user/$userId/location/',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // If needed:
            // "Cookie": "csrftoken=XXX",
          },
        ),
      );

      AppUtils.showSuccess("User locations fetched!");

      return LocationModelResponse.fromJson(response.data);
    } on DioError catch (e) {
      final msg = _handleDioError(e);
      AppUtils.showError(msg);
      throw Exception(msg);
    } catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }


  // create and post api

  Future<Map<String,dynamic>> createInventreeStock({
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      final headers = _dio.options.headers.map(
            (key, value) => MapEntry(key, value.toString()),
      );

      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/stock/create/',
        {"items": items},
        headers,
      );

      final response = await _dio.post(
        '/inventree/stock/create/',
        data: {
          "items": items,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      AppUtils.showSuccess("Stock Created Successfully!");

      return response.data;
    } on DioError catch (e) {
      final errorMessage = _handleDioError(e);
      AppUtils.showError(errorMessage);
      throw Exception(errorMessage);
    } catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }Future<Map<String, dynamic>> bulkTransferBySerial({
    required List<String> serials,
    required num location,
    String? notes,
  }) async {
    try {
      // Clean and validate serials
      final cleanedSerials = _cleanAndValidateSerials(serials);

      if (cleanedSerials.isEmpty) {
        throw Exception("No valid serial numbers provided");
      }

      // Safe header conversion
      final headers = Map<String, String>.fromEntries(
        _dio.options.headers.entries.map(
              (entry) => MapEntry(entry.key, entry.value?.toString() ?? ''),
        ),
      );

      // Print curl before making the request for debugging
      ApiClient.printCurl(
        '${_dio.options.baseUrl}/inventree/stock/bulk-transfer-by-serial/',
        {
          "serials": cleanedSerials,
          "location": location,
          "notes": notes,
        },
        headers,
      );

      final response = await _dio.post(
        '/inventree/stock/bulk-transfer-by-serial/',
        data: {
          "serials": cleanedSerials,
          "location": location,
          "notes": notes,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      // Validate response
      if (response.data == null) {
        throw Exception("Empty response from server");
      }

      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        throw Exception("Invalid response format");
      }

      AppUtils.showSuccess("Bulk Transfer Successful!");
      return responseData;
    } on DioException catch (e) {
      final msg = _handleDioError(e);
      AppUtils.showError(msg);
      throw Exception(msg);
    } catch (e) {
      AppUtils.showError(e.toString());
      throw Exception(e.toString());
    }
  }

// Helper method to clean and validate serials
  List<String> _cleanAndValidateSerials(List<String> serials) {
    return serials
        .map((serial) => serial.trim()) // Remove whitespace
        .where((serial) => serial.isNotEmpty) // Remove empty strings
        .where((serial) => serial != 'null') // Remove 'null' strings
        .toList();
  }
  /// Helper to parse DioError
  String _handleDioError(DioError error) {
    if (error.response != null && error.response?.data != null) {
      try {
        if (error.response?.data is Map<String, dynamic>) {
          return error.response?.data['detail'] ??
              error.response?.data['message'] ??
              "Something went wrong";
        }
        return error.response.toString();
      } catch (_) {
        return "Something went wrong";
      }
    } else {
      return error.message??"";
    }
  }
}
