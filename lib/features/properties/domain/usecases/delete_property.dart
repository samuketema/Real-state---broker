import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/properties/domain/repositories/property_repository.dart';

class DeleteProperty implements Usecase<void, DeletePropertyParams> {
  final PropertyRepository repository;
  DeleteProperty({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeletePropertyParams params) async {
    return await repository.deleteProperty(params.id);
  }
}

class DeletePropertyParams {
  final String id;
  DeletePropertyParams({required this.id});
}
