import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/exception.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:realstate/features/auth/domain/repository/auth_repository.dart';

class Authrepositoryimpl implements AuthRepository {
  final AuthRemoteDatasourceImpl authRemoteDataSource;

  Authrepositoryimpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }catch (e) {
  return left(Failure('Signup failed: $e'));
}
  }
}
