import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:girlfriend_gpt/firebase_service.dart';
import 'package:girlfriend_gpt/page/landing.dart';
import 'package:girlfriend_gpt/secure_storage_service.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        textTheme: TextTheme(
          // displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 30, fontStyle: FontStyle.italic, color: mainColor),
        ),
      ),
      home: const LandingPage(),
    );
  }
}
