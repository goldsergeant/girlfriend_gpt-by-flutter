import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:girlfriend_gpt/main.dart';

import '../../chat/page/charles_chat.dart';
import '../../chat/page/mika_chat.dart';

class BeforeChatPage extends StatelessWidget {
  BeforeChatPage({super.key});

  static const String BOYFRIEND_IMAGE_PATH = "assets/images/gym_rat_man.jpg";
  static const String GIRLFRIEND_IMAGE_PATH = "assets/images/cuty_ani_girl.jpg";

  Widget boyFriendButton() {
    String title = '나만 바라봐주는 남자친구';
    return FittedBox(
        child: InkWell(
      onTap: () => Navigator.push(navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => CharlesChatPage())),
      child: Column(children: [
        Image.asset(
          BOYFRIEND_IMAGE_PATH,
          width: 100,
          height: 100,
        ),
        Text(title),
      ]),
    ));
  }

  Widget girlfriendButton() {
    return FittedBox(
        child: InkWell(
      onTap: () => Navigator.push(navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => MikaChatPage())),
      child: Column(children: [
        Image.asset(
          GIRLFRIEND_IMAGE_PATH,
          width: 100,
          height: 100,
        ),
        Text('나만 바라봐주는 여자친구'),
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
            body: SafeArea(
                child: Center(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [boyFriendButton(), girlfriendButton()],
            )))));
  }
}
