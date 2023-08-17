import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/home/model/character.dart';

Widget characterListTile(Character character) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        character.image!,
        fit: BoxFit.fill,
      ), // Text(key['title']),
    ),
    title: Text(character.name!),
  );
}
