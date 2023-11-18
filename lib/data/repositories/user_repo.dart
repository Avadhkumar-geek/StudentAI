import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_ai/data/models/custom_app_model.dart';
import 'package:student_ai/data/models/user_model.dart';
import 'package:student_ai/data/repositories/auth_repo.dart';

class UserRepo {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");

  static isUserExists(String uid) async {
    final DocumentSnapshot doc = await _userCollection.doc(uid).get();
    return doc.exists;
  }

  static createUser(User user) async {
    await _userCollection.doc(user.uid).set(user.toMap());
  }

  updateUser(String displayName) async {
    try {
      await _userCollection
          .doc(AuthRepo.uid)
          .update({"displayName": displayName});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel> getUserData() async {
    final DocumentSnapshot doc = await _userCollection.doc(AuthRepo.uid).get();
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  static Future<List<CustomAppModel>> getCustomApps() async {
    try {
      log('Reading from firebase');
      final DocumentSnapshot snapshot = await _userCollection
          .doc(AuthRepo.uid)
          .get(const GetOptions(source: Source.server));

      Map<String, dynamic> userDoc = snapshot.data() as Map<String, dynamic>;

      final List<CustomAppModel> customApps = List<CustomAppModel>.from(
        (userDoc['customApps'] as List).map((e) => CustomAppModel.fromJson(e)),
      );

      customApps.map((e) => e.title.toString());

      return customApps;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> addCustomApp(CustomAppModel customApp) async {
    await _userCollection.doc(AuthRepo.uid).update({
      'customApps': FieldValue.arrayUnion([customApp.toJson()]),
    });
  }

  Future<void> editCustomApp(CustomAppModel customApp) async {
    await deleteCustomApp(customApp.appId)
        .then((value) => addCustomApp(customApp));
  }

  Future<void> deleteCustomApp(String appId) async {
    final userDocRef = _userCollection.doc(AuthRepo.uid);
    final customApps = await userDocRef.get().then((doc) => doc['customApps']);
    customApps.removeWhere((map) => map['appId'] == appId);
    await userDocRef.update({
      'customApps': customApps,
    });
  }
}

extension UserParsing on User {
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'uid': uid,
      'customApps': []
    };
  }
}
