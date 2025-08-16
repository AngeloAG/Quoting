part of 'quote_bloc.dart';

enum QuoteStatus {
  initial,
  loading,
  success,
  failure,
  loaded,
  saveSuccess,
  deleteSuccess,
  saveFailure,
  deleteFailure
}

final class QuoteState extends Equatable {
  final QuoteStatus status;
  final List<Quote> quotes;
  final List<Quote> searchedQuotes;
  final String failureMessage;
  final int currentQuoteIndex;
  final int? authorId;
  final int? labelId;
  final int? sourceId;

  const QuoteState({
    this.status = QuoteStatus.initial,
    this.quotes = const [],
    this.searchedQuotes = const [],
    this.failureMessage = '',
    this.currentQuoteIndex = 0,
    this.authorId,
    this.labelId,
    this.sourceId,
  });

  QuoteState copyWith({
    QuoteStatus Function()? status,
    List<Quote> Function(List<Quote> currentQuotes)? quotes,
    List<Quote> Function()? searchedQuotes,
    String Function()? failureMessage,
    int Function()? currentQuoteIndex,
    int? Function()? authorId,
    int? Function()? labelId,
    int? Function()? sourceId,
  }) {
    return QuoteState(
      status: status != null ? status() : this.status,
      quotes: quotes != null ? quotes(this.quotes) : this.quotes,
      searchedQuotes:
          searchedQuotes != null ? searchedQuotes() : this.searchedQuotes,
      failureMessage:
          failureMessage != null ? failureMessage() : this.failureMessage,
      currentQuoteIndex: currentQuoteIndex != null
          ? currentQuoteIndex()
          : this.currentQuoteIndex,
      authorId: authorId != null ? authorId() : this.authorId,
      labelId: labelId != null ? labelId() : this.labelId,
      sourceId: sourceId != null ? sourceId() : this.sourceId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        quotes,
        searchedQuotes,
        failureMessage,
        currentQuoteIndex,
        authorId,
        labelId,
        sourceId
      ];
}
