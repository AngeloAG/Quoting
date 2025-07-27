// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SourceModel {
  final String id;
  final String source;

  SourceModel(
    this.id,
    this.source,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'source': source,
    };
  }

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(
      map['id'] as String,
      map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceModel.fromJson(String source) =>
      SourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
