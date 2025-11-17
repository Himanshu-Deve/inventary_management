import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:inventory_management/repository/api_client.dart';
import 'package:inventory_management/utils/app_utils.dart';

class AuthRepository {
  final Dio _dio = ApiClient.dio;

  /// Send OTP
  Future<bool> login(String username,String password) async {
    try {
      final data={   "username": username,
        "password": password};
      final headers = _dio.options.headers.map((key, value) => MapEntry(key, value.toString()));

      ApiClient.printCurl('${_dio.options.baseUrl}/inventree/login/', data, headers);

      await _dio.post(
        '/inventree/login/',
        data: jsonEncode(data),
      );
      AppUtils.showSuccess( "Login successfully!");
      return true;
    } on DioError catch (e) {
      String errorMessage = _handleDioError(e);
      AppUtils.showError(errorMessage);
      return false;
    } catch (e) {
      AppUtils.showError(e.toString());
      return false;
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
