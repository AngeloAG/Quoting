// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthorModel {
  final String id;
  final String author;

  AuthorModel(
    this.id,
    this.author,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      map['id'] as String,
      map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
