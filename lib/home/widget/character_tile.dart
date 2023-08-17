import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/home/model/character.dart';

Widget characterListTile(Character character) {
  return ListTile(
    leading: Image.network(character.image!),
    title: Text(character.name!),
  );
}
