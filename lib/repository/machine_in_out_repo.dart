import 'dart:convert';
import 'package:dio/dio.dart';
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
