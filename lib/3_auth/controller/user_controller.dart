import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/user_model.dart';

part 'user_controller.g.dart';

@Riverpod(keepAlive: true)
class UserController extends _$UserController {
  late final FirebaseAuth auth;
  late final FirebaseDatabase dbInstance;

  late final FirebaseStorage storageInstance;

  @override
  FutureOr<UserModel?> build() async {
    auth = FirebaseAuth.instance;
    dbInstance = FirebaseDatabase.instance;
    storageInstance = FirebaseStorage.instance;
    return await _getCurrentUser();
  }

  FutureOr<UserModel?> _getCurrentUser() async {
    final checkCurrentUser = auth.currentUser;
    if (checkCurrentUser == null) return null;

    final currentUser = await getCurrentUserInRTDB(checkCurrentUser.uid);
    if (currentUser == null) return null;

    return currentUser;
  }

  Future<UserModel?> getCurrentUserInRTDB(String userId) async {
    final snapshot = await dbInstance.ref().child("Users/$userId").get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.value as Map);
    } else {
      return null;
    }
  }

  Future<void> refreshUser() async {
    debugPrint('user_controller - refreshUser');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getCurrentUser();
    });
  }

  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    debugPrint('user_controller - registerUser');
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final dbRef = dbInstance.ref("Users/${credential.user?.uid}");
      await dbRef.set({
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      });
      return {
        "success": true,
        "message": "Sign up success",
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          "success": false,
          "message": "The password provided is too weak."
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          "success": false,
          "message": "The account already exists for that email."
        };
      } else {
        return {
          "success": false,
          "message": "There is some error, contact admin"
        };
      }
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    debugPrint('user_controller - loginUser');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {"success": true, "message": "Sign In Success."};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {"success": false, "message": "No user found for that email."};
      } else if (e.code == 'wrong-password') {
        return {
          "success": false,
          "message": "Wrong password provided for that user."
        };
      } else {
        return {
          "success": false,
          "message": "There is some error, contact admin"
        };
      }
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required bool profilePictureUpdated,
    required String profilePicture,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String longitude,
    required String latitude,
  }) async {
    try {
      final checkCurrentUser = auth.currentUser!;
      final newAuthCredential = await checkCurrentUser
          .reauthenticateWithCredential(EmailAuthProvider.credential(
              email: checkCurrentUser.email!, password: password));
      await newAuthCredential.user?.updateEmail(email);

      String newProfilePicturePath = profilePicture;
      if (profilePictureUpdated) {
        final userRef = storageInstance
            .ref()
            .child("UsersImages/${newAuthCredential.user?.uid}/");
        File file = File(profilePicture);

        try {
          await userRef.putFile(file);
          newProfilePicturePath = await userRef.getDownloadURL();
        } on PlatformException catch (e) {
          return {
            "success": false,
            "message": "Something went wrong: ${e.message}",
          };
        }
      } else {
        newProfilePicturePath = '-';
      }
      Map<String, dynamic> updatedUserData = {
        'profilePicture': newProfilePicturePath,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
        'longitude': longitude,
        'latitude': latitude,
      };
      final dbRef = dbInstance.ref("Users/${newAuthCredential.user?.uid}");
      dbRef.update(updatedUserData);
      await refreshUser();
      return {
        "success": true,
        "message": "Sign up success",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "success": false,
        "message": "Something went wrong: ${e.message}",
      };
    }
  }

  Future<bool> logout() async {
    await auth.signOut();
    await refreshUser();
    return true;
  }
}
