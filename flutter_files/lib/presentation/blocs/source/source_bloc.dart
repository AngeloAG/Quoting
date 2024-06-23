import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/sources/commands/remove_source_handler.dart';
import 'package:flutter_files/application/sources/commands/update_source_handler.dart';
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

  SourceBloc({required Mediator mediator})
      : _mediator = mediator,
        super(const SourceState()) {
    on<SourceEvent>((event, emit) =>
        emit(state.copyWith(status: () => SourceStatus.loading)));
    on<SourceUploadEvent>(_onSourceUpload);
    on<SourceLoadEvent>(_onSourceLoad);
    on<SourceRemoveEvent>(_onSourceRemove);
    on<SourceUpdateEvent>(_onSourceUpdate);
  }

  void _onSourceUpload(
      SourceUploadEvent event, Emitter<SourceState> emit) async {
    final createSourceWork = CreateSourceWork(source: event.sourceContent);

    final response =
        await _mediator.send<UploadSourceRequest, Either<Failure, Source>>(
            UploadSourceRequest(createSourceWork: createSourceWork));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => SourceStatus.failure,
          failureMessage: () => failure.message)),
      (source) {
        state.sources.add(source);
        emit(state.copyWith(
            status: () => SourceStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onSourceLoad(SourceLoadEvent event, Emitter<SourceState> emit) async {
    final response = await _mediator.send<GetAllSourcesRequest,
        Either<Failure, List<Source>>>(GetAllSourcesRequest());

    response.fold(
      (failure) => emit(state.copyWith(
        status: () => SourceStatus.failure,
        failureMessage: () => failure.message,
      )),
      (sources) => emit(state.copyWith(
          status: () => SourceStatus.success,
          sources: () => sources,
          failureMessage: () => '')),
    );
  }

  void _onSourceRemove(
      SourceRemoveEvent event, Emitter<SourceState> emit) async {
    final response =
        await _mediator.send<RemoveSourceRequest, Either<Failure, Unit>>(
            RemoveSourceRequest(sourceId: event.source.id));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => SourceStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        state.sources.removeWhere((element) => element.id == event.source.id);
        emit(state.copyWith(
          status: () => SourceStatus.success,
          failureMessage: () => '',
        ));
      },
    );
  }

  void _onSourceUpdate(
      SourceUpdateEvent event, Emitter<SourceState> emit) async {
    final response =
        await _mediator.send<UpdateSourceRequest, Either<Failure, Unit>>(
            UpdateSourceRequest(source: event.source));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => SourceStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        state.sources.removeWhere((element) => element.id == event.source.id);
        state.sources.add(event.source);
        emit(state.copyWith(
            status: () => SourceStatus.success, failureMessage: () => ''));
      },
    );
  }
}
