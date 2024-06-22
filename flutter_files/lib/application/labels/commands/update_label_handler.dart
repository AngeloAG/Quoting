import 'package:flutter_files/application/common/interfaces/ilabels_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/works/update_label_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UpdateLabelRequest extends IRequest<Either<Failure, Unit>> {
  final UpdateLabelWork updateLabelWork;

  UpdateLabelRequest({required this.updateLabelWork});
}

class UpdateLabelHandler
    extends IRequestHandler<UpdateLabelRequest, Either<Failure, Unit>> {
  final ILabelsRepository iLabelsRepository;

  UpdateLabelHandler(this.iLabelsRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateLabelRequest request) {
    return iLabelsRepository.updateLabel(request.updateLabelWork).run();
  }
}
