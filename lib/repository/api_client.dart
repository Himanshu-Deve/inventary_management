import 'dart:convert';

import 'package:dio/dio.dart';
import '../config/token_interceptor.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://bd.apnibus.com',
    headers: {
      'Content-Type': 'application/json',
    },
  ))..interceptors.add(TokenInterceptor());


  static void printCurl(String url, Map<String, dynamic> data, Map<String, String> headers) {
    String curl = 'curl -X POST "$url"';

    headers.forEach((key, value) {
      curl += ' -H "$key: $value"';
    });

    if (data.isNotEmpty) {
      String jsonData = jsonEncode(data);
      curl += " -d '$jsonData'";
    }

    print(curl);
  }

}
