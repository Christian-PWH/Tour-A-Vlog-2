// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class CategoryModel {
  final String id;
  final String code;
  final String image;
  final String title;

  const CategoryModel({
    required this.id,
    required this.code,
    required this.image,
    required this.title,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'image': image,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      code: map['code'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CategoryModel copyWith({
    String? id,
    String? code,
    String? image,
    String? title,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      code: code ?? this.code,
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, code: $code, image: $image, title: $title)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.image == image &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ image.hashCode ^ title.hashCode;
  }
}
