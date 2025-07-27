part of 'source_bloc.dart';

@immutable
sealed class SourceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SourceLoadEvent extends SourceEvent {}

final class SourceUploadEvent extends SourceEvent {
  final String sourceContent;

  SourceUploadEvent({required this.sourceContent});
}

final class SourceRemoveEvent extends SourceEvent {
  final Source source;

  SourceRemoveEvent({required this.source});
}

final class SourceUpdateEvent extends SourceEvent {
  final Source source;

  SourceUpdateEvent({required this.source});
}

final class SourceSearchEvent extends SourceEvent {
  final String query;

  SourceSearchEvent({required this.query});
}
