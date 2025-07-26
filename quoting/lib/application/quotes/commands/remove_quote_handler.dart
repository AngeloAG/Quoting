import 'package:quoting/application/common/interfaces/iquotes_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveQuoteRequest extends IRequest<Either<Failure, Unit>> {
  final String quoteId;
  RemoveQuoteRequest(this.quoteId);
}

class RemoveQuoteHandler
    extends IRequestHandler<RemoveQuoteRequest, Either<Failure, Unit>> {
  final IQuotesRepository iQuotesRepository;

  RemoveQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, Unit>> call(RemoveQuoteRequest request) {
    return iQuotesRepository.removeQuoteById(request.quoteId).run();
  }
}
