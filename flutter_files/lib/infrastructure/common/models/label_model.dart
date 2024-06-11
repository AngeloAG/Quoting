// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LabelModel {
  final String id;
  final String label;

  LabelModel(
    this.id,
    this.label,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
    };
  }

  factory LabelModel.fromMap(Map<String, dynamic> map) {
    return LabelModel(
      (map['id'] as int).toString(),
      map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LabelModel.fromJson(String source) =>
      LabelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
