import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class FirebaseService {
  static var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  /// 회원가입
  static Future signUp(String email, String pw) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      logger.w(e);
      rethrow;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  /// 로그인
  static Future signIn(String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      logger.w(e.code);
      rethrow;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  /// 로그아웃
  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// 회원가입, 로그인시 사용자 영속
  void authPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  /// 유저 삭제
  static Future<void> deleteUser(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  /// 현재 유저 정보 조회
  static User? getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user.displayName;
      final email = user.email;

      // Check if user's email is verified
      final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      final uid = user.uid;
    }
    return user;
  }

  /// 공급자로부터 유저 정보 조회
  static User? getUserFromSocial() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.cpm, etc.)
        final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
      }
    }
    return user;
  }

  /// 유저 이름 업데이트
  static Future<void> updateProfileName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }

  /// 유저 url 업데이트
  static Future<void> updateProfileUrl(String url) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }

  /// 비밀번호 초기화 메일보내기
  static Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<UserCredential> googleAuthSignIn() async {
    //구글 Sign in 플로우 오픈
    final GoogleSignInAccount? googleUser = await GoogleSignIn()?.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //읽어온 인증정보로 파이어베이스 인증 로그인
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    //파이어 베이스 Signin하고 결과(userCredential) 리턴
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
