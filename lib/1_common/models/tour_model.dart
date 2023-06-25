// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class TourModel {
  final String id;
  final String category;
  final String city;
  final String code;
  final List<String> customizationForDays;
  final String? about;
  final String details;
  final List<String> image;
  final String? newprice;
  final int? percent;
  final String price;
  final String? status1;
  final String? status2;
  final String title;
  final String type;

  const TourModel({
    required this.id,
    required this.category,
    required this.city,
    required this.code,
    required this.customizationForDays,
    this.about,
    required this.details,
    required this.image,
    this.newprice,
    this.percent,
    required this.price,
    this.status1,
    this.status2,
    required this.title,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'city': city,
      'code': code,
      'customizationForDays': customizationForDays,
      'about': about,
      'details': details,
      'image': image,
      'newprice': newprice,
      'percent': percent,
      'price': price,
      'status1': status1,
      'status2': status2,
      'title': title,
      'type': type,
    };
  }

  factory TourModel.fromMap(Map<dynamic, dynamic> map) {
    debugPrint(map['customizationForDays'].toString());
    int? percentData;
    if (map['percent'] is int) {
      // Kadang bisa string kosong / tidak ada properties / null.
      percentData = map['percent'];
    } else {
      percentData = null;
    }
    return TourModel(
      id: map['id'] as String,
      category: map['category'] as String,
      city: map['city'] as String,
      code: map['code'] as String,
      customizationForDays: (map['customizationForDays'] as List)
          .map((e) => e.toString())
          .toList(),
      about: map['about'] as String?,
      details: map['details'] as String,
      image: (map['image'] as List).map((e) => e.toString()).toList(),
      newprice: map['newprice'] as String?,
      percent: percentData,
      price: map['price'] as String,
      status1: map['status1'] as String?,
      status2: map['status2'] as String?,
      title: map['title'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TourModel.fromJson(String source) =>
      TourModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TourModel copyWith({
    String? id,
    String? category,
    String? city,
    String? code,
    List<String>? customizationForDays,
    String? about,
    String? details,
    List<String>? image,
    String? newprice,
    int? percent,
    String? price,
    String? status1,
    String? status2,
    String? title,
    String? type,
  }) {
    return TourModel(
      id: id ?? this.id,
      category: category ?? this.category,
      city: city ?? this.city,
      code: code ?? this.code,
      customizationForDays: customizationForDays ?? this.customizationForDays,
      about: about ?? this.about,
      details: details ?? this.details,
      image: image ?? this.image,
      newprice: newprice ?? this.newprice,
      percent: percent ?? this.percent,
      price: price ?? this.price,
      status1: status1 ?? this.status1,
      status2: status2 ?? this.status2,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'TourModel(id: $id, category: $category, city: $city, code: $code, customizationForDays: $customizationForDays, about: $about, details: $details, image: $image, newprice: $newprice, percent: $percent, price: $price, status1: $status1, status2: $status2, title: $title, type: $type)';
  }

  @override
  bool operator ==(covariant TourModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.city == city &&
        other.code == code &&
        listEquals(other.customizationForDays, customizationForDays) &&
        other.about == about &&
        other.details == details &&
        listEquals(other.image, image) &&
        other.newprice == newprice &&
        other.percent == percent &&
        other.price == price &&
        other.status1 == status1 &&
        other.status2 == status2 &&
        other.title == title &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        city.hashCode ^
        code.hashCode ^
        customizationForDays.hashCode ^
        about.hashCode ^
        details.hashCode ^
        image.hashCode ^
        newprice.hashCode ^
        percent.hashCode ^
        price.hashCode ^
        status1.hashCode ^
        status2.hashCode ^
        title.hashCode ^
        type.hashCode;
  }
}
