import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:realstate/core/theme/app_theme.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:realstate/features/auth/presentation/pages/sign_in_page.dart';
import 'package:realstate/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(AuthLoggedIn()),
        ),
        BlocProvider<AppUserCubit>(create: (_) => sl<AppUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeMode,
      title: 'Real State',
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedin;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return Scaffold(
              body:  Center(child: Text("LoggedIn"),),
            );
          }
          return const SignInPage();
        },
      ),
    );
  }
}
