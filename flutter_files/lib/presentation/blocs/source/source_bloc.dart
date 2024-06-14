import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/sources/commands/remove_source_handler.dart';
import 'package:flutter_files/application/sources/commands/upload_source_handler.dart';
import 'package:flutter_files/application/sources/queries/get_all_sources_handler.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  final Mediator _mediator;

  SourceBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(SourceInitial()) {
    on<SourceEvent>((event, emit) => emit(SourceLoading()));
    on<SourceUploadEvent>(_onSourceUpload);
    on<SourceLoadEvent>(_onSourceLoad);
    on<SourceRemoveEvent>(_onSourceRemove);
  }

  void _onSourceUpload(
      SourceUploadEvent event, Emitter<SourceState> emit) async {
    final createSourceWork = CreateSourceWork(source: event.sourceContent);

    final response =
        await _mediator.send<UploadSourceRequest, Either<Failure, Unit>>(
            UploadSourceRequest(createSourceWork: createSourceWork));

    response.fold(
      (failure) => emit(SourceFailure(failure.message)),
      (uploadedLabel) => emit(SourceSuccess()),
    );
  }

  void _onSourceLoad(SourceLoadEvent event, Emitter<SourceState> emit) async {
    final response = await _mediator.send<GetAllSourcesRequest,
        Either<Failure, List<Source>>>(GetAllSourcesRequest());

    response.fold(
      (failure) => emit(SourceFailure(failure.message)),
      (labels) => emit(SourceLoadSuccess(labels)),
    );
  }

  void _onSourceRemove(SourceRemoveEvent event, Emitter emit) async {
    final response =
        await _mediator.send<RemoveSourceRequest, Either<Failure, Unit>>(
            RemoveSourceRequest(sourceId: event.sourceId));

    response.fold(
      (failure) => emit(SourceFailure(failure.message)),
      (unit) => emit(SourceSuccess()),
    );
  }
}
