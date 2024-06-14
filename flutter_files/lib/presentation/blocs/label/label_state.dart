part of 'label_bloc.dart';

@immutable
sealed class LabelState {}

final class LabelInitial extends LabelState {}

final class LabelLoading extends LabelState {}

final class LabelSuccess extends LabelState {}

final class LabelFailure extends LabelState {
  final String error;

  LabelFailure(this.error);
}

final class LabelLoadSuccess extends LabelState {
  final List<Label> labels;

  LabelLoadSuccess(this.labels);
}
