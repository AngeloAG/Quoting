part of 'label_bloc.dart';

@immutable
sealed class LabelEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LabelLoadEvent extends LabelEvent {}

final class LabelUploadEvent extends LabelEvent {
  final String labelContent;

  LabelUploadEvent({required this.labelContent});
}

final class LabelRemoveEvent extends LabelEvent {
  final Label label;

  LabelRemoveEvent({required this.label});
}

final class LabelUpdateEvent extends LabelEvent {
  final Label label;

  LabelUpdateEvent({required this.label});
}
