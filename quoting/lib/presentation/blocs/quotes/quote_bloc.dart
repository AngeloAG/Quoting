import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quoting/application/authors/commands/upload_author_handler.dart';
import 'package:quoting/application/labels/commands/upload_label_handler.dart';
import 'package:quoting/application/quotes/commands/remove_quote_handler.dart';
import 'package:quoting/application/quotes/commands/update_quote_handler.dart';
import 'package:quoting/application/quotes/commands/upload_quote_handler.dart';
import 'package:quoting/application/quotes/queries/get_filtered_quotes_handler.dart';
import 'package:quoting/application/quotes/queries/get_paginated_quotes_handler.dart';
import 'package:quoting/application/quotes/queries/search_quote_handler.dart';
import 'package:quoting/application/sources/commands/upload_source_handler.dart';
import 'package:quoting/domain/models/author.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/label.dart';
import 'package:quoting/domain/models/quote.dart';
import 'package:quoting/domain/models/source.dart';
import 'package:quoting/domain/works/create_author_work.dart';
import 'package:quoting/domain/works/create_label_work.dart';
import 'package:quoting/domain/works/create_quote_work.dart';
import 'package:quoting/domain/works/create_source_work.dart';
import 'package:quoting/domain/works/update_quote_work.dart';
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
    // Only set status to loading for actual loading events, not all events
    on<QuoteUploadEvent>(_onQuoteUpload);
    on<QuoteLoadEvent>(_onQuoteLoad);
    on<QuoteReloadEvent>(_onQuoteReload);
    on<QuoteSearchEvent>(_onQuoteSearch);
    on<QuoteUpdateEvent>(_onQuoteUpdate);
    on<QuoteSelectEvent>(_onQuoteSelect);
    on<QuoteRemoveEvent>(_onQuoteRemove);
    on<QuoteFilterEvent>(_onQuoteFilter);
  }

  void _onQuoteSelect(QuoteSelectEvent event, Emitter<QuoteState> emit) async {
    emit(state.copyWith(currentQuoteIndex: () => event.index));
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
                status: () => QuoteStatus.saveFailure,
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
                status: () => QuoteStatus.saveFailure,
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
                status: () => QuoteStatus.saveFailure,
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
          status: () => QuoteStatus.saveFailure,
          failureMessage: () => failure.message)),
      (unit) {
        isLastPage = false;
        emit(state.copyWith(
            status: () => QuoteStatus.saveSuccess, failureMessage: () => ''));
      },
    );
  }

  void _onQuoteLoad(QuoteLoadEvent event, Emitter<QuoteState> emit) async {
    emit(state.copyWith(status: () => QuoteStatus.loading));
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

  void _onQuoteUpdate(QuoteUpdateEvent event, Emitter<QuoteState> emit) async {
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
                status: () => QuoteStatus.saveFailure,
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
                status: () => QuoteStatus.saveFailure,
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
                status: () => QuoteStatus.saveFailure,
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
          status: () => QuoteStatus.saveFailure,
          failureMessage: () => failure.message)),
      (unit) {
        final editedQuoteIndex =
            state.quotes.indexWhere((quote) => quote.id == event.id);
        if (editedQuoteIndex >= 0) {
          state.quotes[editedQuoteIndex] = Quote(
            id: event.id,
            author: Option.fromNullable(author),
            label: Option.fromNullable(label),
            source: Option.fromNullable(source),
            content: event.quoteText,
            details: event.detailsText,
          );
        }
        emit(state.copyWith(
            status: () => QuoteStatus.saveSuccess, failureMessage: () => ''));
      },
    );
  }

  void _onQuoteReload(QuoteReloadEvent event, Emitter<QuoteState> emit) {
    currentPage = 0;
    isLastPage = false;
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

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => QuoteStatus.failure,
          failureMessage: () => failure.message)),
      (quotes) => emit(state.copyWith(
          status: () => QuoteStatus.success,
          searchedQuotes: () => quotes,
          failureMessage: () => '')),
    );
  }

  void _onQuoteRemove(QuoteRemoveEvent event, Emitter<QuoteState> emit) async {
    final response =
        await _mediator.send<RemoveQuoteRequest, Either<Failure, Unit>>(
            RemoveQuoteRequest(event.quote.id));

    response.fold(
      (failure) => emit(state.copyWith(
          status: () => QuoteStatus.deleteFailure,
          failureMessage: () => failure.message)),
      (unit) {
        state.quotes.removeWhere((quote) => quote.id == event.quote.id);
        emit(state.copyWith(
            status: () => QuoteStatus.deleteSuccess, failureMessage: () => ''));
      },
    );
  }

  void _onQuoteFilter(QuoteFilterEvent event, Emitter<QuoteState> emit) async {
    final response = await _mediator
        .send<GetFilteredQuotesRequest, Either<Failure, List<Quote>>>(
            GetFilteredQuotesRequest(
                authorId: event.authorId,
                labelId: event.labelId,
                sourceId: event.sourceId));

    response.fold(
        (failure) => emit(state.copyWith(
            status: () => QuoteStatus.failure,
            failureMessage: () => failure.message)),
        (quotes) => emit(state.copyWith(
            status: () => QuoteStatus.success,
            quotes: (_) => quotes,
            failureMessage: () => '')));
  }
}
