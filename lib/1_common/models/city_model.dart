import 'dart:convert';

class CityModel {
  String code;
  String image;
  String title;

  CityModel({
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

  factory CityModel.fromMap(Map<dynamic, dynamic> map) {
    return CityModel(
      code: map['code'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
