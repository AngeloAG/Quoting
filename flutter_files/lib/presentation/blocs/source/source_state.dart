part of 'source_bloc.dart';

@immutable
sealed class SourceState {}

final class SourceInitial extends SourceState {}

final class SourceLoading extends SourceState {}

final class SourceSuccess extends SourceState {}

final class SourceFailure extends SourceState {
  final String error;

  SourceFailure(this.error);
}

final class SourceLoadSuccess extends SourceState {
  final List<Source> sources;

  SourceLoadSuccess(this.sources);
}
