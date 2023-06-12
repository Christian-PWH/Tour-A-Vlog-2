import 'dart:convert';

import 'package:flutter/material.dart';

enum UserModelEnum {
  uid,
  profilePicture,
  fullName,
  phoneNumber,
  email,
  longitude,
  latitude,
}

@immutable
class UserModel {
  final String? uid;
  final String? profilePicture;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? longitude;
  final String? latitude;

  const UserModel({
    required this.uid,
    this.profilePicture = "",
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.longitude = "",
    this.latitude = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profilePicture': profilePicture,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String?,
      profilePicture: map['profilePicture'] as String?,
      fullName: map['fullName'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
      longitude: map['longitude'] as String?,
      latitude: map['latitudes'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
