import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class RemoveQuoteRequest extends IRequest<Either<Failure, dynamic>> {
  final String quoteId;
  RemoveQuoteRequest(this.quoteId);
}

class RemoveQuoteHandler
    extends IRequestHandler<RemoveQuoteRequest, Either<Failure, dynamic>> {
  final IQuotesRepository iQuotesRepository;

  RemoveQuoteHandler({required this.iQuotesRepository});

  @override
  Future<Either<Failure, dynamic>> call(RemoveQuoteRequest request) {
    return iQuotesRepository.removeQuoteById(request.quoteId);
  }
}
