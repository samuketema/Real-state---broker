import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/properties/domain/entities/property.dart';
import 'package:realstate/features/properties/domain/repositories/property_repository.dart';

class GetPropertyById implements Usecase<Property, GetPropertyByIdParams> {
  final PropertyRepository repository;
  GetPropertyById({required this.repository});

  @override
  Future<Either<Failure, Property>> call(GetPropertyByIdParams params) async {
    return await repository.getPropertyById(params.id);
  }
}

class GetPropertyByIdParams {
  final String id;
  GetPropertyByIdParams({required this.id});
}
