import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/core/secrets/app_secrets/app_secrets.dart';
import 'package:realstate/core/theme/app_theme.dart';
import 'package:realstate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:realstate/features/auth/data/repositories/authrepositoryimpl.dart';
import 'package:realstate/features/auth/domain/usecases/user_sign_up.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:realstate/features/auth/presentation/pages/sign_in_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.annonKey,
  );
  final supabaseClient = supabase.client;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              authRepository: Authrepositoryimpl(
                authRemoteDataSource: AuthRemoteDatasourceImpl(
                  supabase: supabaseClient,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeMode,
      title: 'Real State',
      home: const SignInPage(),
    );
  }
}
