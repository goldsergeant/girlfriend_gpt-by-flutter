import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Future<UserCredential> googleAuthSignIn() async {
    //구글 Sign in 플로우 오픈!
    final GoogleSignInAccount? googleUser = await GoogleSignIn()?.signIn();

    //구글 인증 정보 읽어왓!
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //읽어온 인증정보로 파이어베이스 인증 로그인!
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    //파이어 베이스 Signin하고 결과(userCredential) 리턴햇!
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                // 여기에서 로그인 처리를 수행하거나 필요한 작업을 수행하세요.
                print('Username: $username');
                print('Password: $password');
              },
              child: Text('Login'),
            ),
            ElevatedButton(
                onPressed: () => googleAuthSignIn(), child: Text('구글 로그인')),
          ],
        ),
      ),
    );
  }
}
