import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String BOYFRIEND_IMAGE_PATH = "assets/images/gym_rat_man.jpg";
  static const String GIRLFRIEND_IMAGE_PATH = "assets/images/cuty_any_girl.jpg";

  Widget boyFriendButton() {
    return FittedBox(
        child: InkWell(
      onTap: () => Null,
      child: Column(children: [
        Image.asset(
          BOYFRIEND_IMAGE_PATH,
          width: 100,
          height: 100,
        ),
        Text('나만 바라봐주는 남자친구'),
      ]),
    ));
  }

  Widget girlfriendButton() {
    return FittedBox(
        child: InkWell(
      onTap: () => Null,
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
    return Scaffold(
        appBar: AppBar(
          title: Text('GirlFriend GPT'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
                child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [boyFriendButton(), girlfriendButton()],
        ))));
  }
}
