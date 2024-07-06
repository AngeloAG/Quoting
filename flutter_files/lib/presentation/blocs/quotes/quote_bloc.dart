import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_files/application/authors/commands/upload_author_handler.dart';
import 'package:flutter_files/application/labels/commands/upload_label_handler.dart';
import 'package:flutter_files/application/quotes/commands/upload_quote_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_all_quotes_handler.dart';
import 'package:flutter_files/application/quotes/queries/get_paginated_quotes_handler.dart';
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
    on<QuoteCheckIfNeedMoreDataEvent>(_onCheckIfNeedMoreData);
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
    // final response =
    //     await _mediator.send<GetAllQuotesRequest, Either<Failure, List<Quote>>>(
    //         GetAllQuotesRequest());
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

  void _onCheckIfNeedMoreData(
      QuoteCheckIfNeedMoreDataEvent event, Emitter<QuoteState> emit) {
    if (event.index == state.quotes.length - nextPageTrigger && !isLastPage) {
      add(QuoteLoadEvent());
    }
  }
}
