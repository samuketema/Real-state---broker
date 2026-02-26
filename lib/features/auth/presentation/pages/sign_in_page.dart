import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/core/theme/app_palette.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:realstate/features/auth/presentation/pages/sign_up_page.dart';
import 'package:realstate/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:realstate/features/auth/presentation/widgets/box_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully logged in')));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.18),
                    Image.asset(
                      'assets/images/logo.png',
                      height: screenHeight * 0.18,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Welcome back to Betlink",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    BoxField(
                      hintText: "Enter your email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    BoxField(
                      isPassword: true,
                      hintText: "Ent er your password",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 25),
                    AuthElevatedButton(
                      text: "Sign In",
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formkey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                      AuthLogIn(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPalette.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
