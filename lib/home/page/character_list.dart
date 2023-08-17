import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/home/service/character_service.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  _buildList(BuildContext context) {
    return FutureBuilder(
        future: CharacterService().getCharacterList(context),
        builder: ((context, snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          } //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Text('성공');
          }
        }));
  }

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
          body: _buildList(context),
        ));
  }
}
