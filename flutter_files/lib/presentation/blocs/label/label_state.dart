part of 'label_bloc.dart';

@immutable
sealed class LabelState {}

final class LabelInitial extends LabelState {}

final class LabelLoading extends LabelState {}

final class LabelUploadSuccess extends LabelState {
  final Label label;

  LabelUploadSuccess(this.label);
}

final class LabelUploadFailure extends LabelState {
  final String error;

  LabelUploadFailure(this.error);
}
