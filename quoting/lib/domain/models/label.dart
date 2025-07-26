import 'package:equatable/equatable.dart';

class Label extends Equatable {
  final String id;
  final String label;

  const Label({
    required this.id,
    required this.label,
  });

  @override
  List<Object> get props => [id, label];

  @override
  String toString() => label;
}
