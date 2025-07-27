import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quoting/application/sources/commands/remove_source_handler.dart';
import 'package:quoting/application/sources/commands/update_source_handler.dart';
import 'package:quoting/application/sources/commands/upload_source_handler.dart';
import 'package:quoting/application/sources/queries/get_all_sources_handler.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:quoting/domain/works/create_source_work.dart';
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
    on<SourceSearchEvent>(_onSourceSeach);
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
        emit(state.copyWith(
            status: () => SourceStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onSourceLoad(SourceLoadEvent event, Emitter<SourceState> emit) async {
    final response = await _mediator.send<GetAllSourcesRequest,
        Either<Failure, Stream<List<Source>>>>(GetAllSourcesRequest());

    await response.fold(
      (failure) async => emit(state.copyWith(
        status: () => SourceStatus.failure,
        failureMessage: () => failure.message,
      )),
      (sourcesStream) async => emit.forEach<List<Source>>(sourcesStream,
          onData: (sources) => state.copyWith(
              status: () => SourceStatus.success,
              sources: () => sources,
              failureMessage: () => ''),
          onError: (_, __) => state.copyWith(
              status: () => SourceStatus.failure,
              failureMessage: () => 'Failed to fetch the sources')),
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
        emit(state.copyWith(
            status: () => SourceStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onSourceSeach(SourceSearchEvent event, Emitter<SourceState> emit) {
    emit(state.copyWith(
      status: () => SourceStatus.success,
      searchedSources: (currentSources) => currentSources
          .where((source) =>
              source.source.toLowerCase().contains(event.query.toLowerCase()))
          .toList(),
    ));
  }
}
