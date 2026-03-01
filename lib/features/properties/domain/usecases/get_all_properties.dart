import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/properties/domain/entities/property.dart';
import 'package:realstate/features/properties/domain/repositories/property_repository.dart';

class GetAllProperties implements Usecase<List<Property>, NoParams> {
  final PropertyRepository repository;
  GetAllProperties({required this.repository});
  @override
  Future<Either<Failure, List<Property>>> call(NoParams params) async {
    return await repository.getAllProperties();
  }
}
