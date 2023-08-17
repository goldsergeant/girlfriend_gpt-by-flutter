import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/auth/auth_dio.dart';
import 'package:logger/logger.dart';

class ChatService {
  static var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  static sendToMika(BuildContext context, String message) async {
    var data = '';
    try {
      var dio = await authDio(context);
      final response =
          await dio.post('chat/mika/message/', data: {'content': message});
      data = response.data['message'];
    } on DioException catch (e) {
      logger.w(e.message);
      logger.w(e.response);
    }
    return data;
  }

  static sendToCharles(BuildContext context, String message) async {
    var data = '';
    try {
      var dio = await authDio(context);
      final response =
          await dio.post('chat/charles/message/', data: {'content': message});
      data = response.data['message'];
    } on DioException catch (e) {
      logger.w(e.message);
      logger.w(e.response);
    }
    return data;
  }
}
