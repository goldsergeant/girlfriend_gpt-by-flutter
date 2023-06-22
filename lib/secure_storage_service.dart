import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static FlutterSecureStorage storage =
      new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  static Future<String?> readUserInfo() async {
    String? userInfo = await storage.read(key: "login");
    return userInfo;
  }

  static writeUserInfo(String email, String password) async {
    await storage.write(
        key: "login", value: "id ${email} password ${password}");
  }
}
