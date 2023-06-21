import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girlfriend_gpt/page/landing.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../firebase_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String google_image_path = "assets/images/btn_google_dark_normal_ios.svg";
  final _formKey = GlobalKey<FormState>();
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void goLandingPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

  // _login() async {
  //   //키보드 숨기기
  //   if (_formKey.currentState!.validate()) {
  //     FocusScope.of(context).requestFocus(FocusNode());

  //     // Firebase 사용자 인증, 사용자 등록
  //     try {
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text,
  //         password: _passwordController.text,
  //       );

  //       // Get.offAll(() => const MarketPage());
  //     } on FirebaseAuthException catch (e) {
  //       logger.e(e);
  //       String message = '';

  //       if (e.code == 'user-not-found') {
  //         message = '사용자가 존재하지 않습니다.';
  //       } else if (e.code == 'wrong-password') {
  //         message = '비밀번호를 확인하세요';
  //       } else if (e.code == 'invalid-email') {
  //         message = '이메일을 확인하세요.';
  //       }

  //       /*final snackBar = SnackBar(
  //         content: Text(message),
  //         backgroundColor: Colors.deepOrange,
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     */

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(message),
  //           backgroundColor: Colors.deepOrange,
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Girlfriend GPT',
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(
              height: 70.0,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !EmailValidator.validate(value)) {
                          return 'invalid email';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'invalid password';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        String email = _emailController.text;
                        String password = _passwordController.text;

                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseService.signIn(email, password);
                            goLandingPage();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('유효하지 않은 값을 고쳐주세요.')));
                        }
                      },
                      child: Text('로그인'),
                    ),
                  ],
                )),
            Container(
              height: 30,
            ),
            IconButton(
                icon: SvgPicture.asset(
                  google_image_path,
                ),
                onPressed: () => FirebaseService.googleAuthSignIn()),
          ],
        ),
      ),
    );
  }
}
