import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girlfriend_gpt/services/auth_service.dart';
import 'package:girlfriend_gpt/services/secure_storage_service.dart';
import 'package:logger/logger.dart';

import 'login.dart';

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
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void goLoginPage() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
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
                  style: Theme.of(context).textTheme.titleLarge,
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
                            if (value!.isEmpty ||
                                !EmailValidator.validate(value)) {
                              return 'invalid email';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'input name';
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
                            String name = _nameController.text;
                            String password = _passwordController.text;

                            if (_formKey.currentState!.validate()) {
                              final response = await AuthService.signUp(
                                  email, name, password);
                              if (response.statusCode == 201) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('회원가입 성공')));
                                goLoginPage();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(response.data['detail'])));
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
                      fit: BoxFit.fill,
                    ),
                    onPressed: () async {
                      goLoginPage();
                    }),
              ],
            ),
          ),
        ));
  }
}
