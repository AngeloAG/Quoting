part of 'quote_bloc.dart';

enum QuoteStatus { initial, loading, success, failure, loaded }

final class QuoteState extends Equatable {
  final QuoteStatus status;
  final List<Quote> quotes;
  final String failureMessage;
  final int currentQuoteIndex;

  const QuoteState({
    this.status = QuoteStatus.initial,
    this.quotes = const [],
    this.failureMessage = '',
    this.currentQuoteIndex = 0,
  });

  QuoteState copyWith({
    QuoteStatus Function()? status,
    List<Quote> Function(List<Quote> currentQuotes)? quotes,
    String Function()? failureMessage,
    int Function()? currentQuoteIndex,
  }) {
    return QuoteState(
      status: status != null ? status() : this.status,
      quotes: quotes != null ? quotes(this.quotes) : this.quotes,
      failureMessage:
          failureMessage != null ? failureMessage() : this.failureMessage,
      currentQuoteIndex: currentQuoteIndex != null
          ? currentQuoteIndex()
          : this.currentQuoteIndex,
    );
  }

  @override
  List<Object?> get props =>
      [status, quotes, failureMessage, currentQuoteIndex];
}
