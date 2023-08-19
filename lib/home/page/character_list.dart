import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/home/service/character_service.dart';
import 'package:girlfriend_gpt/home/widget/character_listview.dart';
import 'package:girlfriend_gpt/home/widget/character_tile.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/cherryblossom.gif"),
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('GirlFriend GPT'),
            centerTitle: true,
          ),
          body: characterListView(context),
        ));
  }
}
