import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_ui/models/user.dart';
import 'package:twitter_ui/services/utils.dart';

class UserService {
  UtilsService utilsService = UtilsService();

  UserModel? userFromFirebaseSnapshot(DocumentSnapshot? snapshot) {
    final data = snapshot?.data() as Map<String, dynamic>;
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            name: data['name'],
            email: data['email'],
            profileImageUrl: data['profileImageUrl'],
            bannerImageUrl: data['bannerImageUrl'],
          )
        : null;
  }

  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(userFromFirebaseSnapshot);
  }

  Future updateProfile(
      File? bannerImage, File? profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (bannerImage != null) {
      // Save to storage
      bannerImageUrl = await utilsService.uploadFile(bannerImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/banner');
    }
    if (profileImage != null) {
      // Save to Storage
      profileImageUrl = await utilsService.uploadFile(profileImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/profile');
    }

    Map<String, Object> data = HashMap();
    if (name != '') {
      data['name'] = name;
    }
    if (bannerImageUrl != '') {
      data['bannerImageUrl'] = bannerImageUrl;
    }
    if (profileImageUrl != '') {
      data['profileImageUrl'] = profileImageUrl;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(data);
  }
}
