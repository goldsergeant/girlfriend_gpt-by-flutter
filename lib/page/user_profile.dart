import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/services/firebase_service.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _validator(String? nickName) {
    if (nickName!.replaceAll(' ', '').isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    return null;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    final _dialogTextFieldController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('수정할 닉네임'),
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
                    await FirebaseService.updateProfileName(
                        _dialogTextFieldController.text);
                    _dialogTextFieldController.dispose();
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: Text('입력')),
          ],
        );
      },
    );
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
              title: Text('마이페이지'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/images/user_image.jpg"), // 프로필 이미지
                  ),
                  SizedBox(height: 16),
                  Text(
                    FirebaseService.getUser()!.displayName ?? '닉네임을 입력해주세요',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _displayTextInputDialog(context);
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            )));
  }
}
