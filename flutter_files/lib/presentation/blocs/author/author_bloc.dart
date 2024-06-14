import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/authors/commands/remove_author_handler.dart';
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

  AuthorBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(AuthorInitial()) {
    on<AuthorEvent>((event, emit) => emit(AuthorLoading()));
    on<AuthorUploadEvent>(_onAuthorUpload);
    on<AuthorLoadEvent>(_onAuthorLoad);
    on<AuthorRemoveEvent>(_onAuthorRemove);
  }

  void _onAuthorUpload(
      AuthorUploadEvent event, Emitter<AuthorState> emit) async {
    final createAuthorWork = CreateAuthorWork(name: event.authorContent);

    final response =
        await _mediator.send<UploadAuthorRequest, Either<Failure, Unit>>(
            UploadAuthorRequest(createAuthorWork: createAuthorWork));

    response.fold(
      (failure) => emit(AuthorFailure(failure.message)),
      (_) => emit(AuthorSuccess()),
    );
  }

  void _onAuthorLoad(AuthorLoadEvent event, Emitter<AuthorState> emit) async {
    final response = await _mediator.send<GetAllAuthorsRequest,
        Either<Failure, List<Author>>>(GetAllAuthorsRequest());

    response.fold(
      (failure) => emit(AuthorFailure(failure.message)),
      (_) => emit(AuthorSuccess()),
    );
  }

  void _onAuthorRemove(
      AuthorRemoveEvent event, Emitter<AuthorState> emit) async {
    final response =
        await _mediator.send<RemoveAuthorRequest, Either<Failure, Unit>>(
            RemoveAuthorRequest(authorId: event.authorId));

    response.fold(
      (failure) => emit(AuthorFailure(failure.message)),
      (_) => emit(AuthorSuccess()),
    );
  }
}
