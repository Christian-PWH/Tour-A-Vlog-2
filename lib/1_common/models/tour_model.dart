import 'dart:convert';

class TourModel {
  String category;
  String city;
  String code;
  List<String> customizationForDays;
  String details;
  List<String> image;
  String? newprice;
  int? percent;
  String price;
  String? status1;
  String? status2;
  String title;
  String type;

  TourModel({
    required this.category,
    required this.city,
    required this.code,
    required this.customizationForDays,
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
      'category': category,
      'city': city,
      'code': code,
      'customizationForDays': customizationForDays,
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
    return TourModel(
      category: map['category'] as String,
      city: map['city'] as String,
      code: map['code'] as String,
      customizationForDays: map['customizationForDays'] as List<String>,
      details: map['details'] as String,
      image: map['image'] as List<String>,
      newprice: map['newprice'] as String?,
      percent: map['percent'] as int?,
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
}
