import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/services/firebase_service.dart';

class UserProfilePage extends StatelessWidget {
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
                      // 프로필 편집 기능 구현
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            )));
  }
}
