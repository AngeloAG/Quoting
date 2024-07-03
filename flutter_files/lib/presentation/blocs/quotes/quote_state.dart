part of 'quote_bloc.dart';

enum QuoteStatus { initial, loading, success, failure, loaded }

final class QuoteState extends Equatable {
  final QuoteStatus status;
  final List<Quote> quotes;
  final String failureMessage;

  const QuoteState({
    this.status = QuoteStatus.initial,
    this.quotes = const [],
    this.failureMessage = '',
  });

  QuoteState copyWith({
    QuoteStatus Function()? status,
    List<Quote> Function()? quotes,
    String Function()? failureMessage,
  }) {
    return QuoteState(
      status: status != null ? status() : this.status,
      quotes: quotes != null ? quotes() : this.quotes,
      failureMessage:
          failureMessage != null ? failureMessage() : this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [status, quotes, failureMessage];
}
