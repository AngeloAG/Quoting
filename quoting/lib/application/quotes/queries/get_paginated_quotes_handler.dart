import 'package:quoting/application/common/interfaces/iquotes_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/quote.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetPaginatedQuotesRequest
    implements IRequest<Either<Failure, List<Quote>>> {
  final int amountOfQuotes;
  final int offset;

  GetPaginatedQuotesRequest(this.amountOfQuotes, this.offset);
}

class GetPaginatedQuotesHandler
    implements
        IRequestHandler<GetPaginatedQuotesRequest,
            Either<Failure, List<Quote>>> {
  final IQuotesRepository iQuotesRepository;

  GetPaginatedQuotesHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, List<Quote>>> call(GetPaginatedQuotesRequest request) {
    return iQuotesRepository
        .getPaginatedQuotes(request.amountOfQuotes, request.offset)
        .run();
  }
}
