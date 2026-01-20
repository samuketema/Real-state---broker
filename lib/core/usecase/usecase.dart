import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure,SuccessType>> call(Params params);
}