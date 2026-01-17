import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure,String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<Either<Failure,String>> logInWithEmailPassword({
    required String email,
    required String password
  });
}