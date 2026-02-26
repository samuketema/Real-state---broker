import 'package:get_it/get_it.dart';
import 'package:realstate/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:realstate/core/secrets/app_secrets/app_secrets.dart';
import 'package:realstate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:realstate/features/auth/data/repositories/authrepositoryimpl.dart';
import 'package:realstate/features/auth/domain/repository/auth_repository.dart';
import 'package:realstate/features/auth/domain/usecases/user_log_in.dart';
import 'package:realstate/features/auth/domain/usecases/user_loggedIn.dart';
import 'package:realstate/features/auth/domain/usecases/user_sign_up.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.annonKey,
  );
  sl.registerLazySingleton(() => supabase.client);
  sl.registerLazySingleton(() => AppUserCubit(),);
  _initAUth();
}

void _initAUth() {
  sl.registerFactory<AuthRemoteDatasource>(()=>AuthRemoteDatasourceImpl(supabase: sl()));
  sl.registerFactory<AuthRepository>(()=>AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerFactory(()=>UserSignUp(authRepository: sl()));
  sl.registerFactory(() => UserLogIn(authReopsitory: sl()));
  sl.registerFactory(() => UserLoggedin(authRepository: sl()));
  sl.registerLazySingleton(()=> AuthBloc(appUserCubit: sl(), userSignUp: sl(), userLogIn: sl(), userLoggedin: sl()));
}
    