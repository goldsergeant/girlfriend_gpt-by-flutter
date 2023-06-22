import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:girlfriend_gpt/firebase_service.dart';
import 'package:girlfriend_gpt/model/user.dart';

class FireStoreService {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static writeUserInfo(String nickName) async {
    User userModel = User(nickName: nickName);
    String uid = FirebaseService.getUser()!.uid;
    await users.doc(uid).set(userModel.toJson());
  }

  static Future<User?> getUserInfo(String uid) async {
    final snapshot = await users.doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return User.fromJson(data);
    } else {
      return null;
    }
  }
}
