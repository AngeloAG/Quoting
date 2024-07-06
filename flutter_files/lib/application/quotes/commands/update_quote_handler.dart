import 'package:flutter_files/application/common/interfaces/iquotes_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/update_quote_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UpdateQuoteRequest implements IRequest<Either<Failure, Unit>> {
  final UpdateQuoteWork updateQuoteWork;

  UpdateQuoteRequest(this.updateQuoteWork);
}

class UpdateQuoteHandler
    implements IRequestHandler<UpdateQuoteRequest, Either<Failure, Unit>> {
  final IQuotesRepository iQuotesRepository;

  UpdateQuoteHandler(this.iQuotesRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateQuoteRequest request) {
    return iQuotesRepository.updateQuote(request.updateQuoteWork).run();
  }
}
