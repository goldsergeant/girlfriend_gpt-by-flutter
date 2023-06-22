import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:girlfriend_gpt/firebase_service.dart';
import 'package:girlfriend_gpt/page/landing.dart';
import 'package:girlfriend_gpt/secure_storage_service.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
