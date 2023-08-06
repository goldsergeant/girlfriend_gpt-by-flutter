import 'package:flutter/material.dart';
import 'package:girlfriend_gpt/page/home.dart';
import 'package:girlfriend_gpt/page/login.dart';
import 'package:girlfriend_gpt/services/firebase_service.dart';
import 'package:girlfriend_gpt/services/secure_storage_service.dart';
import 'env/env.dart';
import 'package:dart_openai/dart_openai.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  OpenAI.apiKey = Env.apiKey;
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  String? userInfo = await SecureStorageService.readUserInfo();

  if (userInfo != null) {
    String email = userInfo.split(" ")[1];
    String password = userInfo.split(" ")[3];

    FirebaseService.signIn(email, password);
  }
// Ideal time to initialize
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color mainColor = Color.fromARGB(255, 233, 145, 175);
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Girlfriend GPT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: mainColor,
        ),
        primaryColor: mainColor,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: TextTheme(
          // displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 30, fontStyle: FontStyle.italic, color: mainColor),
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
