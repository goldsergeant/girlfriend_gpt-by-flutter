import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import '../auth/auth_dio.dart';
import '../env/env.dart';

class AuthService {
  static String BASEURL = "http://127.0.0.1:8000/";
  static String CONTENTTYPE = "application/json";
  static Future login(String email, String password) async {
    var dio = Dio();
    dio.options.baseUrl = BASEURL;
    dio.options.contentType = CONTENTTYPE;

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
      return handler.next(error); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
    Response response;
    try {
      response = await dio.post(
        'auth/signin/',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
        final accessToken = response.data['access'];
        final refreshToken = response.data['refresh'];

        // 기기에 저장된 AccessToken과 RefreshToken 갱신
        storage.write(key: 'ACCESS_TOKEN', value: accessToken);
        storage.write(key: 'REFRESH_TOKEN', value: refreshToken);

        return response;
      }
    } on DioException catch (e) {
      return e.response;
    }
  }

  static Future signUp(String email, String name, String password) async {
    var dio = Dio();
    dio.options.baseUrl = 'http://127.0.0.1:8000/';
    dio.options.contentType = 'application/json';

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
      return handler.next(error); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
    Response response;
    try {
      response = await dio.post(
        'auth/signup/',
        data: {'email': email, 'name': name, 'password': password},
      );

      if (response.statusCode == 201) {
        // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
        return response;
      }
    } on DioException catch (e) {
      return e.response;
    }
  }

  static getUserInfo(BuildContext context) async {
    Dio dio = await authDio(context);
    final response = await dio.get('auth/user/info/');
    return response;
  }

  static updateUserName(context, String name) async {
    var dio = await authDio(context);
    dio.put('auth/user/name/', data: {'name': name});
  }

  static googleLogin() async {
    // 고유한 redirect uri
    const APP_REDIRECT_URI = "girlfriend-gpt";

    // Construct the url
    final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'response_type': 'code',
      'client_id': Env.googleClientId,
      'redirect_uri': '$APP_REDIRECT_URI:/',
      'scope': 'https://www.googleapis.com/auth/userinfo.email',
    });

// Present the dialog to the user
    final result = await FlutterWebAuth2.authenticate(
        url: url.toString(), callbackUrlScheme: APP_REDIRECT_URI);

// Extract code from resulting url
    final code = Uri.parse(result).queryParameters['code'];

// Construct an Uri to Google's oauth2 endpoint
    final url2 =
        Uri.https('localhost:8000', 'auth/google/callback/', {'code': code});

// Use this code to get an access token
    final response = await http.get(url2);

// Get the access token from the response
    final accessToken = jsonDecode(response.body)['access_token'] as String;
  }
}
