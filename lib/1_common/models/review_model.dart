// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tour_a_vlog/1_common/models/user_model.dart';

@immutable
class ReviewModel {
  final String id;
  final UserModel user;
  final int star;
  final String comment;
  const ReviewModel({
    required this.id,
    required this.user,
    required this.star,
    required this.comment,
  });

  ReviewModel copyWith({
    String? id,
    UserModel? user,
    int? star,
    String? comment,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      user: user ?? this.user,
      star: star ?? this.star,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'star': star,
      'comment': comment,
    };
  }

  factory ReviewModel.fromMap(Map<dynamic, dynamic> map) {
    return ReviewModel(
      id: map['id'] as String,
      user: UserModel.fromMap(map['user'] as Map<dynamic, dynamic>),
      star: map['star'] as int,
      comment: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(id: $id, user: $user, star: $star, comment: $comment)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.star == star &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ star.hashCode ^ comment.hashCode;
  }
}
