import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetAllQuotesRequest
    extends IRequest<Either<Failure, Stream<List<Quote>>>> {}

class GetAllQuotesHandler extends IRequestHandler<GetAllQuotesRequest,
    Either<Failure, Stream<List<Quote>>>> {
  final IQuotesRepository iQuotesRepository;

  GetAllQuotesHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, Stream<List<Quote>>>> call(
      GetAllQuotesRequest request) {
    return iQuotesRepository.getAllQuotes().run();
  }
}
