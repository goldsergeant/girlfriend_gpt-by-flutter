import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/auth_dio.dart';

class AuthService {
  static Future login(
      BuildContext context, String email, String password) async {
    var dio = Dio();
    dio.options.baseUrl = 'http://10.0.2.2:8000/';
    dio.options.contentType = 'application/json';

    final storage = FlutterSecureStorage();
    dio.interceptors.clear();

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (error, handler) {
      // Do something with response error
      return error.response!.data; //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    final response = await dio.post(
      'auth/signin/',
      data: {'email': email, 'password': password},
    );
    // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
    final accessToken = response.headers['access']![0];
    final refreshToken = response.headers['refresh']![0];

    // 기기에 저장된 AccessToken과 RefreshToken 갱신
    storage.write(key: 'ACCESS_TOKEN', value: accessToken);
    storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
  }
}
