import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveQuoteRequest extends IRequest<Either<String, dynamic>> {
  final String quoteId;
  RemoveQuoteRequest(this.quoteId);
}

class RemoveQuoteHandler
    extends IRequestHandler<RemoveQuoteRequest, Either<String, dynamic>> {
  final IQuotesRepository iQuotesRepository;

  RemoveQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<String, dynamic>> call(RemoveQuoteRequest request) {
    return iQuotesRepository.removeQuoteById(request.quoteId);
  }
}
