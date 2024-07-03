import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/authors/commands/remove_author_handler.dart';
import 'package:flutter_files/application/authors/commands/update_author_handler.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/authors/queries/get_all_authors_handler.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final Mediator _mediator;

  AuthorBloc({required Mediator mediator})
      : _mediator = mediator,
        super(const AuthorState()) {
    on<AuthorEvent>((event, emit) =>
        emit(state.copyWith(status: () => AuthorStatus.loading)));
    on<AuthorUploadEvent>(_onAuthorUpload);
    on<AuthorLoadEvent>(_onAuthorLoad);
    on<AuthorRemoveEvent>(_onAuthorRemove);
    on<AuthorUpdateEvent>(_onAuthorUpdate);
  }

  void _onAuthorUpload(
      AuthorUploadEvent event, Emitter<AuthorState> emit) async {
    final createAuthorWork = CreateAuthorWork(name: event.authorName);

    final response =
        await _mediator.send<UploadAuthorRequest, Either<Failure, Author>>(
            UploadAuthorRequest(createAuthorWork: createAuthorWork));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => AuthorStatus.failure,
          failureMessage: () => failure.message)),
      (author) {
        state.authors.add(author);
        emit(state.copyWith(
            status: () => AuthorStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onAuthorLoad(AuthorLoadEvent event, Emitter<AuthorState> emit) async {
    final response = await _mediator.send<GetAllAuthorsRequest,
        Either<Failure, Stream<List<Author>>>>(GetAllAuthorsRequest());

    await response.fold(
      (failure) async => emit(state.copyWith(
          status: () => AuthorStatus.failure,
          failureMessage: () => failure.message)),
      (authorsStream) async => emit.forEach<List<Author>>(
        authorsStream,
        onData: (authors) => state.copyWith(
            status: () => AuthorStatus.loaded,
            authors: () => authors,
            failureMessage: () => ''),
        onError: (_, __) => state.copyWith(
            status: () => AuthorStatus.failure,
            failureMessage: () => 'Failed to fetch the authors'),
      ),
    );
  }

  void _onAuthorRemove(
      AuthorRemoveEvent event, Emitter<AuthorState> emit) async {
    final response =
        await _mediator.send<RemoveAuthorRequest, Either<Failure, Unit>>(
            RemoveAuthorRequest(authorId: event.author.id));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => AuthorStatus.failure, failureMessage: () => '')),
      (unit) {
        state.authors.remove(event.author);
        emit(state.copyWith(
            status: () => AuthorStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onAuthorUpdate(
      AuthorUpdateEvent event, Emitter<AuthorState> emit) async {
    final response =
        await _mediator.send<UpdateAuthorRequest, Either<Failure, Unit>>(
            UpdateAuthorRequest(author: event.author));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => AuthorStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        state.authors.removeWhere((element) => element.id == event.author.id);
        state.authors.add(event.author);
        emit(state.copyWith(
            status: () => AuthorStatus.success, failureMessage: () => ''));
      },
    );
  }
}
