import 'dart:convert';

class QuoteModel {
  final String id;
  final String? author;
  final String? authorId;
  final String? label;
  final String? labelId;
  final String? source;
  final String? sourceId;
  final String details;
  final String content;

  QuoteModel(
    this.id,
    this.author,
    this.authorId,
    this.label,
    this.labelId,
    this.source,
    this.sourceId,
    this.details,
    this.content,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'authorId': authorId,
      'label': label,
      'labelId': labelId,
      'source': source,
      'sourceId': sourceId,
      'details': details,
      'content': content,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      map['id'] as String,
      map['author'] as String,
      map['authorId'] as String,
      map['label'] as String,
      map['labelId'] as String,
      map['source'] as String,
      map['sourceId'] as String,
      map['details'] as String,
      map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteModel.fromJson(String source) =>
      QuoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
