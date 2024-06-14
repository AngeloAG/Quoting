part of 'source_bloc.dart';

@immutable
sealed class SourceEvent {}

final class SourceUploadEvent extends SourceEvent {
  final String sourceContent;

  SourceUploadEvent({required this.sourceContent});
}

final class SourceLoadEvent extends SourceEvent {}

final class SourceRemoveEvent extends SourceEvent {
  final String sourceId;

  SourceRemoveEvent({required this.sourceId});
}
