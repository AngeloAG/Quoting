part of 'source_bloc.dart';

enum SourceStatus { initial, loading, success, failure, loaded }

final class SourceState extends Equatable {
  final SourceStatus status;
  final List<Source> sources;
  final String failureMessage;

  const SourceState({
    this.status = SourceStatus.initial,
    this.sources = const [],
    this.failureMessage = '',
  });

  SourceState copyWith({
    SourceStatus Function()? status,
    List<Source> Function()? sources,
    String Function()? failureMessage,
  }) {
    return SourceState(
      status: status != null ? status() : this.status,
      sources: sources != null ? sources() : this.sources,
      failureMessage:
          failureMessage != null ? failureMessage() : this.failureMessage,
    );
  }

  @override
  List<Object> get props => [status, sources, failureMessage];
}
