import 'dart:convert';

class TypeModel {
  String code;
  String title;

  TypeModel({
    required this.code,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'title': title,
    };
  }

  factory TypeModel.fromMap(Map<dynamic, dynamic> map) {
    return TypeModel(
      code: map['code'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeModel.fromJson(String source) =>
      TypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
