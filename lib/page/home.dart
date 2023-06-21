import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String BOYFRIEND_IMAGE_PATH = "assets/images/gym_rat_man.jpg";

  Widget boyFriendButton() {
    return InkWell(
      onTap: () => Null,
      child: Row(children: [
        Image.asset(
          BOYFRIEND_IMAGE_PATH,
          width: 100,
          height: 100,
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [boyFriendButton()],
    ));
  }
}
