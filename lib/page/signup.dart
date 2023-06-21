import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../firebase_service.dart';
import 'landing.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
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
                            await FirebaseService.signUp(email, password);
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('유효하지 않은 값을 고쳐주세요.')));
                        }
                      },
                      child: Text('회원가입'),
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
                onPressed: () async {
                  await FirebaseService.googleAuthSignIn();
                  goLandingPage();
                }),
          ],
        ),
      ),
    );
  }
}
