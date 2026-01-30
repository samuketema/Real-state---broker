// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/auth/domain/entities/user.dart';
import 'package:realstate/features/auth/domain/repository/auth_repository.dart';

class UserLoggedin implements Usecase<User,NoParams> {
  AuthRepository authRepository;
  UserLoggedin({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(NoParams params) async{
   return await authRepository.getCurrentUser();
  }
  
}

