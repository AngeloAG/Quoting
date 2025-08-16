import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';
import 'package:quoting/application/common/interfaces/iquotes_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/quote.dart';

class GetFilteredQuotesRequest extends IRequest<Either<Failure, List<Quote>>> {
  final int? authorId;
  final int? labelId;
  final int? sourceId;

  GetFilteredQuotesRequest({
    this.authorId,
    this.labelId,
    this.sourceId,
  });
}

class GetFilteredQuotesHandler extends IRequestHandler<GetFilteredQuotesRequest,
    Either<Failure, List<Quote>>> {
  final IQuotesRepository iQuotesRepository;

  GetFilteredQuotesHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, List<Quote>>> call(GetFilteredQuotesRequest request) {
    return iQuotesRepository
        .getFilteredQuotes(
          authorId: request.authorId,
          labelId: request.labelId,
          sourceId: request.sourceId,
        )
        .run();
  }
}
