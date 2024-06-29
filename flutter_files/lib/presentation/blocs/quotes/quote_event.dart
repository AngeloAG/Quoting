part of 'quote_bloc.dart';

@immutable
sealed class QuoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class QuoteUploadEvent extends QuoteEvent {
  final Author? author;
  final String? authorText;
  final Label? label;
  final String? labelText;
  final Source? source;
  final String? sourceText;
  final String quoteText;
  final String detailsText;

  QuoteUploadEvent({
    required this.author,
    required this.authorText,
    required this.label,
    required this.labelText,
    required this.source,
    required this.sourceText,
    required this.quoteText,
    required this.detailsText,
  });
}

final class QuoteLoadEvent extends QuoteEvent {}

final class QuoteRemoveEvent extends QuoteEvent {
  final Quote quote;

  QuoteRemoveEvent({required this.quote});
}

final class QuoteUpdateEvent extends QuoteEvent {
  final Quote quote;

  QuoteUpdateEvent({required this.quote});
}