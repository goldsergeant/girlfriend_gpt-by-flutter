import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/home/service/character_service.dart';
import 'package:girlfriend_gpt/home/widget/character_tile.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  _buildList(BuildContext context) {
    return FutureBuilder(
        future: CharacterService().getCharacterList(context),
        builder: ((context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: characterListTile(snapshot.data![index]));
              },
              padding: EdgeInsets.all(12.0),
            );
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
