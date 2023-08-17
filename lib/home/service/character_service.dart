import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/auth/auth_dio.dart';
import 'package:girlfriend_gpt/home/model/character.dart';
import 'package:logger/logger.dart';

class CharacterService {
  CharacterService._privateConstructor();
  static final CharacterService _instance =
      CharacterService._privateConstructor();

  factory CharacterService() {
    return _instance;
  }
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  Future<List> getCharacterList(BuildContext context) async {
    var list = [];
    try {
      var dio = await authDio(context);
      final response = await dio.get('chat/characters/');
      for (var element in response.data) {
        list.add(Character.fromJson(element));
      }
    } on DioException catch (e) {
      logger.w(e.message);
      logger.w(e.response);
    }
    return list;
  }
}
