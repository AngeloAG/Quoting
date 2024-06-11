part of 'label_bloc.dart';

@immutable
sealed class LabelEvent {}

final class LabelUploadEvent extends LabelEvent {
  final String labelContent;

  LabelUploadEvent({required this.labelContent});
}

final class LabelLoadEvent extends LabelEvent {}
