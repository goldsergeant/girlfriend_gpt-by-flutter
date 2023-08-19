import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/chat/page/chatting_page.dart';

import '../service/character_service.dart';
import 'character_tile.dart';

Widget characterListView(BuildContext context) {
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
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChattingPage(character: snapshot.data![index]),
                        ));
                  },
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: characterListTile(snapshot.data![index])));
            },
            padding: EdgeInsets.all(12.0),
          );
        }
      }));
}
