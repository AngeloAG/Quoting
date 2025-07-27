part of 'label_bloc.dart';

enum LabelStatus { initial, loading, success, failure, loaded }

final class LabelState extends Equatable {
  final LabelStatus status;
  final List<Label> labels;
  final List<Label> searchedLabels;
  final String failureMessage;

  const LabelState({
    this.status = LabelStatus.initial,
    this.labels = const [],
    this.searchedLabels = const [],
    this.failureMessage = '',
  });

  LabelState copyWith({
    LabelStatus Function()? status,
    List<Label> Function()? labels,
    List<Label> Function(List<Label> currentLabels)? searchedLabels,
    String Function()? failureMessage,
  }) {
    return LabelState(
      status: status != null ? status() : this.status,
      labels: labels != null ? labels() : this.labels,
      searchedLabels: searchedLabels != null
          ? searchedLabels(this.labels)
          : this.searchedLabels,
      failureMessage:
          failureMessage != null ? failureMessage() : this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [status, labels, searchedLabels, failureMessage];
}
