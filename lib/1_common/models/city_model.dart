// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class CityModel {
  final String id;
  final String code;
  final String title;
  final String image;

  const CityModel({
    required this.id,
    required this.code,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'title': title,
      'image': image,
    };
  }

  factory CityModel.fromMap(Map<dynamic, dynamic> map) {
    return CityModel(
      id: map['id'] as String,
      code: map['code'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CityModel copyWith({
    String? id,
    String? code,
    String? title,
    String? image,
  }) {
    return CityModel(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  @override
  String toString() => 'CityModel(code: $code, title: $title, image: $image)';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.image == image && other.title == title;
  }

  @override
  int get hashCode => code.hashCode ^ image.hashCode ^ title.hashCode;
}
