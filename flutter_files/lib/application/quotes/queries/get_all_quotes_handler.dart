import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/quote.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetAllQuotesRequest extends IRequest<Either<Failure, List<Quote>>> {}

class GetAllQuotesHandler
    extends IRequestHandler<GetAllQuotesRequest, Either<Failure, List<Quote>>> {
  final IQuotesRepository iQuotesRepository;

  GetAllQuotesHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, List<Quote>>> call(GetAllQuotesRequest request) {
    return iQuotesRepository.getAllQuotes().run();
  }
}
