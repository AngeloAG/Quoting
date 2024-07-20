import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/labels/commands/remove_label_handler.dart';
import 'package:flutter_files/application/labels/commands/update_label_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/labels/queries/get_all_labels_handler.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:flutter_files/domain/works/update_label_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'label_event.dart';
part 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  final Mediator _mediator;

  LabelBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(const LabelState()) {
    on<LabelEvent>((event, emit) =>
        emit(state.copyWith(status: () => LabelStatus.loading)));
    on<LabelUploadEvent>(_onLabelUpload);
    on<LabelLoadEvent>(_onLabelLoad);
    on<LabelRemoveEvent>(_onLabelRemove);
    on<LabelUpdateEvent>(_onLabelUpdate);
  }

  void _onLabelUpload(LabelUploadEvent event, Emitter<LabelState> emit) async {
    final createLabelWork = CreateLabelWork(label: event.labelContent);

    final response =
        await _mediator.send<UploadLabelRequest, Either<Failure, Label>>(
            UploadLabelRequest(createLabelWork: createLabelWork));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => LabelStatus.failure,
          failureMessage: () => failure.message)),
      (uploadedLabel) {
        emit(state.copyWith(
            status: () => LabelStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onLabelLoad(LabelLoadEvent event, Emitter<LabelState> emit) async {
    final response = await _mediator.send<GetAllLabelsRequest,
        Either<Failure, Stream<List<Label>>>>(GetAllLabelsRequest());

    await response.fold(
        (failure) async => emit(state.copyWith(
            status: () => LabelStatus.failure,
            failureMessage: () => failure.message)),
        (labelsStream) async => emit.forEach<List<Label>>(labelsStream,
            onData: (labels) => state.copyWith(
                status: () => LabelStatus.loaded,
                failureMessage: () => '',
                labels: () => labels),
            onError: (_, __) => state.copyWith(
                  status: () => LabelStatus.failure,
                  failureMessage: () => 'Failed to fetch the labels',
                )));
  }

  void _onLabelRemove(LabelRemoveEvent event, Emitter emit) async {
    final response =
        await _mediator.send<RemoveLabelRequest, Either<Failure, Unit>>(
            RemoveLabelRequest(labelId: event.label.id));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => LabelStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        emit(state.copyWith(
            status: () => LabelStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onLabelUpdate(LabelUpdateEvent event, Emitter emit) async {
    final labelUpdateWork =
        UpdateLabelWork(id: event.label.id, label: event.label.label);

    final response =
        await _mediator.send<UpdateLabelRequest, Either<Failure, Unit>>(
            UpdateLabelRequest(updateLabelWork: labelUpdateWork));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => LabelStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        emit(state.copyWith(
            status: () => LabelStatus.success, failureMessage: () => ''));
      },
    );
  }
}
