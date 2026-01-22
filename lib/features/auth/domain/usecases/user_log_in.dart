import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/auth/domain/repository/auth_repository.dart';

class UserLogIn implements Usecase<String, UserLogInParams> {
  final AuthRepository authReopsitory;

  UserLogIn({required this.authReopsitory});
  @override
  Future<Either<Failure, String>> call(UserLogInParams params) async{
       return await authReopsitory.logInWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}
