import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:flutter_files/domain/works/create_quote_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadQuoteRequest extends IRequest<Either<Failure, Quote>> {
  final CreateQuoteWork createQuoteWork;

  UploadQuoteRequest(this.createQuoteWork);
}

class UploadQuoteHandler
    extends IRequestHandler<UploadQuoteRequest, Either<Failure, Quote>> {
  final IQuotesRepository iQuotesRepository;

  UploadQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, Quote>> call(UploadQuoteRequest request) {
    return iQuotesRepository.uploadQuote(request.createQuoteWork).run();
  }
}
