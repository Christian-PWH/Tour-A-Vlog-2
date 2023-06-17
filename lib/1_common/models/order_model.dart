// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class OrderModel {
  final String id;
  final String tourId;
  final String userId;
  final String status;
  final String fullName;
  final String numberPhone;
  final String email;
  final int quantity;
  final double price;
  final double totalPrice;
  final DateTime bookingDate;

  const OrderModel({
    required this.id,
    required this.tourId,
    required this.userId,
    required this.status,
    required this.fullName,
    required this.numberPhone,
    required this.email,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.bookingDate,
  });

  OrderModel copyWith({
    String? id,
    String? tourId,
    String? userId,
    String? status,
    String? fullName,
    String? numberPhone,
    String? email,
    int? quantity,
    double? price,
    double? totalPrice,
    DateTime? bookingDate,
  }) {
    return OrderModel(
      id: id ?? this.id,
      tourId: tourId ?? this.tourId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      numberPhone: numberPhone ?? this.numberPhone,
      email: email ?? this.email,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      bookingDate: bookingDate ?? this.bookingDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tourId': tourId,
      'userId': userId,
      'status': status,
      'fullName': fullName,
      'numberPhone': numberPhone,
      'email': email,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      tourId: map['tourId'] as String,
      userId: map['userId'] as String,
      status: map['status'] as String,
      fullName: map['fullName'] as String,
      numberPhone: map['numberPhone'] as String,
      email: map['email'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      totalPrice: map['totalPrice'] as double,
      bookingDate: DateTime.parse(map['bookingDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, tourId: $tourId, userId: $userId, status: $status, fullName: $fullName, numberPhone: $numberPhone, email: $email, quantity: $quantity, price: $price, totalPrice: $totalPrice, bookingDate: $bookingDate)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tourId == tourId &&
        other.userId == userId &&
        other.status == status &&
        other.fullName == fullName &&
        other.numberPhone == numberPhone &&
        other.email == email &&
        other.quantity == quantity &&
        other.price == price &&
        other.totalPrice == totalPrice &&
        other.bookingDate == bookingDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tourId.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        fullName.hashCode ^
        numberPhone.hashCode ^
        email.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        totalPrice.hashCode ^
        bookingDate.hashCode;
  }
}
