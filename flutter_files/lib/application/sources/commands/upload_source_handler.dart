import 'package:flutter_files/application/common/interfaces/isources_repository.dart';
import 'package:flutter_files/domain/models/failure.dart';
import 'package:flutter_files/domain/models/source.dart';
import 'package:flutter_files/domain/works/create_source_work.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mediatr/mediatr.dart';

class UploadSourceRequest extends IRequest<Either<Failure, Source>> {
  final CreateSourceWork createSourceWork;

  UploadSourceRequest({required this.createSourceWork});
}

class UploadSourceHandler
    extends IRequestHandler<UploadSourceRequest, Either<Failure, Source>> {
  final ISourcesRepository iSourcesRepository;

  UploadSourceHandler(this.iSourcesRepository);

  @override
  Future<Either<Failure, Source>> call(UploadSourceRequest request) {
    return iSourcesRepository.uploadSource(request.createSourceWork).run();
  }
}
