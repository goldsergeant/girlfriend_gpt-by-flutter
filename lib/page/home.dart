import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:girlfriend_gpt/services/firebase_service.dart';
import 'package:girlfriend_gpt/services/firestore_service.dart';
import 'package:girlfriend_gpt/main.dart';
import 'package:girlfriend_gpt/page/boyfriend_chat.dart';

import '../model/user.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const String BOYFRIEND_IMAGE_PATH = "assets/images/gym_rat_man.jpg";
  static const String GIRLFRIEND_IMAGE_PATH = "assets/images/cuty_any_girl.jpg";
  final _dialogTextFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget boyFriendButton() {
    String title = '나만 바라봐주는 남자친구';
    return FittedBox(
        child: InkWell(
      onTap: () => Navigator.push(navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => BoyfriendChatPage())),
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

  String? _validator(String? nickName) {
    if (nickName!.replaceAll(' ', '').isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    return null;
  }

  Future<void> _displayTextInputDialog() async {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('닉네임'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: _validator,
              controller: _dialogTextFieldController,
              decoration: InputDecoration(hintText: "닉네임"),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FireStoreService.writeUserInfo(
                        _dialogTextFieldController.text);
                    _dialogTextFieldController.dispose();
                    Navigator.pop(context);
                  }
                },
                child: Text('입력')),
          ],
        );
      },
    );
  }

  _buildDialogByUserData(BuildContext context) async {
    String uid = FirebaseService.getUser()!.uid;
    User? user = await FireStoreService.getUserInfo(uid);
    if (user == null) {
      _displayTextInputDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildDialogByUserData(context);
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
