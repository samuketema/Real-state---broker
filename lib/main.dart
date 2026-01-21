import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/core/theme/app_theme.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:realstate/features/auth/presentation/pages/sign_in_page.dart';
import 'package:realstate/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()
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
