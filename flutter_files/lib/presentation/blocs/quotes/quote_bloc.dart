import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/quotes/commands/update_quote_handler.dart';
import 'package:flutter_files/application/quotes/commands/upload_quote_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_paginated_quotes_handler.dart';
import 'package:flutter_files/application/quotes/queries/search_quote_handler.dart';
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
import 'package:flutter_files/domain/works/update_quote_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final Mediator _mediator;

  final int quotesPerPage = 5;
  bool isLastPage = false;
  int currentPage = 0;
  int nextPageTrigger = 1;

  QuoteBloc({
    required Mediator mediator,
  })  : _mediator = mediator,
        super(const QuoteState()) {
    on<QuoteEvent>((event, emit) =>
        emit(state.copyWith(status: () => QuoteStatus.loading)));
    on<QuoteUploadEvent>(_onQuoteUpload);
    on<QuoteLoadEvent>(_onQuoteLoad);
    on<QuoteReloadEvent>(_onQuoteReload);
    on<QuoteSearchEvent>(_onQuoteSearch);
  }

  void _onQuoteUpload(QuoteUploadEvent event, Emitter<QuoteState> emit) async {
    Author? author;
    if (event.author != null) {
      author = event.author as Author;
    } else {
      if (event.authorText.isNotEmpty) {
        final response =
            await _mediator.send<UploadAuthorRequest, Either<Failure, Author>>(
                UploadAuthorRequest(
                    createAuthorWork:
                        CreateAuthorWork(name: event.authorText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedAuthor) => author = uploadedAuthor);
      }
    }

    Label? label;
    if (event.label != null) {
      label = event.label as Label;
    } else {
      if (event.labelText.isNotEmpty) {
        final response =
            await _mediator.send<UploadLabelRequest, Either<Failure, Label>>(
                UploadLabelRequest(
                    createLabelWork: CreateLabelWork(label: event.labelText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedLabel) => label = uploadedLabel);
      }
    }

    Source? source;
    if (event.source != null) {
      source = event.source as Source;
    } else {
      if (event.sourceText.isNotEmpty) {
        final response =
            await _mediator.send<UploadSourceRequest, Either<Failure, Source>>(
                UploadSourceRequest(
                    createSourceWork:
                        CreateSourceWork(source: event.sourceText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedSource) => source = uploadedSource);
      }
    }

    final createQuoteWork = CreateQuoteWork(
      authorId: Option.fromNullable(author?.id),
      labelId: Option.fromNullable(label?.id),
      sourceId: Option.fromNullable(source?.id),
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
      (unit) {
        emit(state.copyWith(
            status: () => QuoteStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onQuoteLoad(QuoteLoadEvent event, Emitter<QuoteState> emit) async {
    final response = await _mediator
        .send<GetPaginatedQuotesRequest, Either<Failure, List<Quote>>>(
            GetPaginatedQuotesRequest(quotesPerPage, currentPage));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () => failure.message)),
      (quotes) {
        isLastPage = quotes.length < quotesPerPage;
        currentPage += isLastPage ? quotes.length : quotesPerPage;

        emit(state.copyWith(
            status: () => QuoteStatus.loaded,
            quotes: (currentQuotes) {
              quotes.insertAll(0, currentQuotes);
              return quotes;
            },
            failureMessage: () => ''));
      },
    );
  }

  void onQuoteUpdate(QuoteUpdateEvent event, Emitter<QuoteState> emit) async {
    Author? author;
    if (event.author != null && event.authorText == event.author?.name) {
      author = event.author as Author;
    } else {
      if (event.authorText.isNotEmpty) {
        final response =
            await _mediator.send<UploadAuthorRequest, Either<Failure, Author>>(
                UploadAuthorRequest(
                    createAuthorWork:
                        CreateAuthorWork(name: event.authorText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedAuthor) => author = uploadedAuthor);
      }
    }

    Label? label;
    if (event.label != null && event.labelText == event.label?.label) {
      label = event.label as Label;
    } else {
      if (event.labelText.isNotEmpty) {
        final response =
            await _mediator.send<UploadLabelRequest, Either<Failure, Label>>(
                UploadLabelRequest(
                    createLabelWork: CreateLabelWork(label: event.labelText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedLabel) => label = uploadedLabel);
      }
    }

    Source? source;
    if (event.source != null && event.sourceText == event.source?.source) {
      source = event.source as Source;
    } else {
      if (event.sourceText.isNotEmpty) {
        final response =
            await _mediator.send<UploadSourceRequest, Either<Failure, Source>>(
                UploadSourceRequest(
                    createSourceWork:
                        CreateSourceWork(source: event.sourceText)));

        response.fold(
            (failure) => emit(state.copyWith(
                status: () => QuoteStatus.failure,
                failureMessage: () => failure.message)),
            (uploadedSource) => source = uploadedSource);
      }
    }

    final updateQuoteWork = UpdateQuoteWork(
        id: event.id,
        authorId: Option.fromNullable(author?.id),
        labelId: Option.fromNullable(label?.id),
        sourceId: Option.fromNullable(source?.id),
        content: event.quoteText,
        details: event.detailsText);

    final response =
        await _mediator.send<UpdateQuoteRequest, Either<Failure, Unit>>(
            UpdateQuoteRequest(updateQuoteWork));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () => failure.message)),
      (unit) {
        emit(state.copyWith(
            status: () => QuoteStatus.success, failureMessage: () => ''));
      },
    );
  }

  void _onQuoteReload(QuoteReloadEvent event, Emitter<QuoteState> emit) {
    emit(state.copyWith(
        status: () => QuoteStatus.loading,
        failureMessage: () => '',
        quotes: (quotes) => []));
    add(QuoteLoadEvent());
  }

  void _onQuoteSearch(QuoteSearchEvent event, Emitter<QuoteState> emit) async {
    final response =
        await _mediator.send<SearchQuoteRequest, Either<Failure, List<Quote>>>(
            SearchQuoteRequest(event.query));

    Failure f;
    List<Quote> s;
    response.fold(
      (l) => f = l,
      (r) => s = r,
    );
  }
}
