import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/properties/domain/entities/property.dart';
import 'package:realstate/features/properties/domain/repositories/property_repository.dart';

class AddProperty implements Usecase<void, Property> {
  final PropertyRepository repository;
  AddProperty({required this.repository});

  @override
  Future<Either<Failure, void>> call(Property params) async {
    return await repository.addProperty(params);
  }
}
