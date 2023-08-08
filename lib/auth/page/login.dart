import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girlfriend_gpt/auth/auth_dio.dart';
import 'package:girlfriend_gpt/auth/page/signup.dart';
import 'package:girlfriend_gpt/auth/widget/google_login_widget.dart';
import 'package:girlfriend_gpt/home/page/home.dart';
import 'package:girlfriend_gpt/services/auth_service.dart';
import 'package:girlfriend_gpt/services/secure_storage_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String GOOGLE_IMAGE_PATH =
      "assets/images/btn_google_dark_normal_ios.svg";
  final _formKey = GlobalKey<FormState>();
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void goHomePage() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  void goSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void _submit() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      final response = await AuthService.login(email, password);
      if (response.statusCode == 200) {
        goHomePage();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.data['messages'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('유효하지 않은 값을 고쳐주세요.')));
    }
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
                        obscureText: true,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _submit(),
                            child: Text('로그인'),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: () => goSignUpPage(),
                              child: Text('회원가입'))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                ),
                IconButton(
                    icon: SvgPicture.asset(
                      GOOGLE_IMAGE_PATH,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    onPressed: () async {
                      showGoogleModal(context);
                      // goHomePage();
                    }),
              ],
            ),
          ),
        ));
  }
}
