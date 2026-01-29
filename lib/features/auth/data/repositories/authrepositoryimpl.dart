import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/exception.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:realstate/features/auth/domain/entities/user.dart';
import 'package:realstate/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  })async {
    try {
      final res = await authRemoteDataSource.logInWithEmailPassword(email: email, password: password);
    return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }catch(e){
      return left(Failure('Signup failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
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
  
  @override
  Future<Either<Failure, User>> getCurrentUser()async {
    try {
      final user = await authRemoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure("User is not logged in"));
      }
     return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
