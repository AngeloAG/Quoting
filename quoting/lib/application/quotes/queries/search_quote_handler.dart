import 'package:quoting/application/common/interfaces/iquotes_repository.dart';
import 'package:quoting/domain/models/failure.dart';
import 'package:quoting/domain/models/quote.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class SearchQuoteRequest extends IRequest<Either<Failure, List<Quote>>> {
  final String query;

  SearchQuoteRequest(this.query);
}

class SearchQuoteHandler
    extends IRequestHandler<SearchQuoteRequest, Either<Failure, List<Quote>>> {
  final IQuotesRepository iQuotesRepository;

  SearchQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, List<Quote>>> call(SearchQuoteRequest request) {
    return iQuotesRepository.searchQuotes(request.query).run();
  }
}
