import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/auth_dio.dart';

class AuthService {
  static Future<Response> login(
      BuildContext context, String email, String password) async {
    var dio = Dio();
    dio.options.baseUrl = 'http://10.0.2.2:8000/';
    dio.options.contentType = 'application/json';

    final storage = FlutterSecureStorage();

    final response = await dio
        .post('auth/signin/', data: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
      final accessToken = response.headers['access']![0];
      final refreshToken = response.headers['refresh']![0];

      // 기기에 저장된 AccessToken과 RefreshToken 갱신
      await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
    }
    return response;
  }
}
