import 'package:quoting/application/common/interfaces/iquotes_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/works/create_quote_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadQuoteRequest extends IRequest<Either<Failure, Unit>> {
  final CreateQuoteWork createQuoteWork;

  UploadQuoteRequest(this.createQuoteWork);
}

class UploadQuoteHandler
    extends IRequestHandler<UploadQuoteRequest, Either<Failure, Unit>> {
  final IQuotesRepository iQuotesRepository;

  UploadQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, Unit>> call(UploadQuoteRequest request) {
    return iQuotesRepository.uploadQuote(request.createQuoteWork).run();
  }
}
