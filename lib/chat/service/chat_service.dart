import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/auth/auth_dio.dart';
import 'package:logger/logger.dart';

class ChatService {
  ChatService._privateConstructor();
  static final ChatService _instance = ChatService._privateConstructor();

  factory ChatService() {
    return _instance;
  }
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  sendToLover(BuildContext context, String sendUrl, String message) async {
    var data = '';
    try {
      var dio = await authDio(context);
      final response = await dio.post(sendUrl, data: {'content': message});
      data = response.data['message'];
    } on DioException catch (e) {
      logger.w(e.message);
      logger.w(e.response);
    }
    return data;
  }
}
