import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
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
  }

  void _onLabelUpload(LabelUploadEvent event, Emitter<LabelState> emit) async {
    final createLabelWork = CreateLabelWork(label: event.labelContent);

    final response =
        await _mediator.send<UploadLabelRequest, Either<String, Label>>(
            UploadLabelRequest(createLabelWork));

    response.fold(
      (errorString) => emit(LabelUploadFailure(errorString)),
      (uploadedLabel) => emit(LabelUploadSuccess(uploadedLabel)),
    );
  }
}
