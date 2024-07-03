import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/label.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class GetAllLabelsRequest
    extends IRequest<Either<Failure, Stream<List<Label>>>> {}

class GetAllLabelsHandler extends IRequestHandler<GetAllLabelsRequest,
    Either<Failure, Stream<List<Label>>>> {
  final ILabelsRepository iLabelsRepository;

  GetAllLabelsHandler(this.iLabelsRepository);

  @override
  Future<Either<Failure, Stream<List<Label>>>> call(
      GetAllLabelsRequest request) {
    return iLabelsRepository.getAllLabels().run();
  }
}
