// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime? date;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    this.date,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<dynamic, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, description: $description, date: $date)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ date.hashCode;
  }
}
