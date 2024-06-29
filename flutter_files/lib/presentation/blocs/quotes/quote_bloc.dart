import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/quotes/commands/upload_quote_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_all_quotes_handler.dart';
import 'package:flutter_files/application/sources/commands/upload_source_handler.dart';
import 'package:flutter_files/domain/models/author.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_author_work.dart';
import 'package:flutter_files/domain/works/create_label_work.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final Mediator _mediator;

  QuoteBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(const QuoteState()) {
    on<QuoteEvent>((event, emit) =>
        emit(state.copyWith(status: () => QuoteStatus.loading)));
    on<QuoteUploadEvent>(_onQuoteUpload);
    on<QuoteLoadEvent>(_onQuoteLoad);
  }

  void _onQuoteUpload(QuoteUploadEvent event, Emitter<QuoteState> emit) async {
    if (event.author == null && event.authorText == null ||
        event.author != null && event.authorText != null) {
      emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () =>
              'Failed to process new quote both the author and author text cannot be both empty or populated at the same time'));
    }

    if (event.label == null && event.labelText == null ||
        event.label != null && event.labelText != null) {
      emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () =>
              'Failed to process new quote both the label and label text cannot be both empty or populated at the same time'));
    }

    if (event.source == null && event.sourceText == null ||
        event.source != null && event.sourceText != null) {
      emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () =>
              'Failed to process new quote both the source and source text cannot be both empty or populated at the same time'));
    }

    Author author = Author(id: '', name: '');
    if (event.author != null) {
      author = event.author as Author;
    } else {
      final response =
          await _mediator.send<UploadAuthorRequest, Either<Failure, Author>>(
              UploadAuthorRequest(
                  createAuthorWork:
                      CreateAuthorWork(name: event.authorText as String)));

      response.fold(
          (failure) => emit(state.copyWith(
              status: () => QuoteStatus.failure,
              failureMessage: () => failure.message)),
          (uploadedAuthor) => author = uploadedAuthor);
    }

    Label label = const Label(id: '', label: '');
    if (event.label != null) {
      label = event.label as Label;
    } else {
      final response = await _mediator
          .send<UploadLabelRequest, Either<Failure, Label>>(UploadLabelRequest(
              createLabelWork:
                  CreateLabelWork(label: event.labelText as String)));

      response.fold(
          (failure) => emit(state.copyWith(
              status: () => QuoteStatus.failure,
              failureMessage: () => failure.message)),
          (uploadedLabel) => label = uploadedLabel);
    }

    Source source = Source(id: '', source: '');
    if (event.source != null) {
      source = event.source as Source;
    } else {
      final response =
          await _mediator.send<UploadSourceRequest, Either<Failure, Source>>(
              UploadSourceRequest(
                  createSourceWork:
                      CreateSourceWork(source: event.sourceText as String)));

      response.fold(
          (failure) => emit(state.copyWith(
              status: () => QuoteStatus.failure,
              failureMessage: () => failure.message)),
          (uploadedSource) => source = uploadedSource);
    }

    if (author.id.isEmpty || label.id.isEmpty || source.id.isEmpty) {
      emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () =>
              'An unexpected error happened when uploading the quote, please try again later.'));
    }

    final createQuoteWork = CreateQuoteWork(
      authorId: author.id,
      labelId: label.id,
      sourceId: source.id,
      details: event.detailsText,
      content: event.quoteText,
    );

    final response =
        await _mediator.send<UploadQuoteRequest, Either<Failure, Unit>>(
            UploadQuoteRequest(createQuoteWork));

    response.fold(
        (failure) => emit(state.copyWith(
            status: () => QuoteStatus.failure,
            failureMessage: () => failure.message)),
        (unit) => emit(state.copyWith(
            status: () => QuoteStatus.success, failureMessage: () => '')));
  }

  void _onQuoteLoad(QuoteLoadEvent event, Emitter<QuoteState> emit) async {
    final response = await _mediator.send<GetAllQuotesRequest,
        Either<Failure, Stream<List<Quote>>>>(GetAllQuotesRequest());

    await response.fold(
        (failure) async => emit(state.copyWith(
            status: () => QuoteStatus.failure,
            failureMessage: () => failure.message)),
        (quotesStream) async => emit.forEach<List<Quote>>(quotesStream,
            onData: (quotes) => state.copyWith(
                status: () => QuoteStatus.loaded, quotes: () => quotes),
            onError: (_, __) => state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => 'Failed to fetch the quotes')));
  }
}
