import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:girlfriend_gpt/auth/auth_dio.dart';
import 'package:girlfriend_gpt/home/page/user_profile.dart';
import 'package:girlfriend_gpt/services/auth_service.dart';

import '../../services/firebase_service.dart';
import 'before_chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _dialogTextFieldController = TextEditingController();

  final List<Widget> _widgetOptions = <Widget>[
    BeforeChatPage(),
    UserProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? _validator(String? nickName) {
    if (nickName!.replaceAll(' ', '').isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    return null;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
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
                    await AuthService.updateUserName(
                        context, _dialogTextFieldController.text);
                    Navigator.pop(context);
                    _dialogTextFieldController.dispose();
                  }
                },
                child: Text('입력')),
          ],
        );
      },
    );
  }

  _buildDialogByUserData(BuildContext context) async {
    Response response = await AuthService.getUserInfo(context);
    String name = response.data['name'];
    if (name == "") {
      _displayTextInputDialog(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildDialogByUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
