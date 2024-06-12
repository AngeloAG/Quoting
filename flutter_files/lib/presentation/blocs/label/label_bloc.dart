import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/labels/commands/remove_label_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/labels/queries/get_all_labels_handler.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'label_event.dart';
part 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  final Mediator _mediator;

  LabelBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(LabelInitial()) {
    on<LabelEvent>((event, emit) => emit(LabelLoading()));
    on<LabelUploadEvent>(_onLabelUpload);
    on<LabelLoadEvent>(_onLabelLoad);
    on<LabelRemoveEvent>(_onLabelRemove);
  }

  void _onLabelUpload(LabelUploadEvent event, Emitter<LabelState> emit) async {
    final createLabelWork = CreateLabelWork(label: event.labelContent);

    final response =
        await _mediator.send<UploadLabelRequest, Either<Failure, Unit>>(
            UploadLabelRequest(createLabelWork: createLabelWork));

    response.fold(
      (failure) => emit(LabelUploadFailure(failure.message)),
      (uploadedLabel) => emit(LabelUploadSuccess()),
    );
  }

  void _onLabelLoad(LabelLoadEvent event, Emitter<LabelState> emit) async {
    final response =
        await _mediator.send<GetAllLabelsRequest, Either<Failure, List<Label>>>(
            GetAllLabelsRequest());

    response.fold(
      (failure) => emit(LabelLoadFailure(failure.message)),
      (labels) => emit(LabelLoadSuccess(labels)),
    );
  }

  void _onLabelRemove(LabelRemoveEvent event, Emitter emit) async {
    final response =
        await _mediator.send<RemoveLabelRequest, Either<Failure, Unit>>(
            RemoveLabelRequest(labelId: event.labelId));

    response.fold(
      (failure) => emit(LabelRemoveFailure(failure.message)),
      (unit) => emit(LabelRemoveSuccess()),
    );
  }
}
