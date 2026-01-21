import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/core/theme/app_palette.dart';
import 'package:realstate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:realstate/features/auth/presentation/pages/sign_in_page.dart';
import 'package:realstate/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:realstate/features/auth/presentation/widgets/box_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              // allows scrolling if keyboard overlaps
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.18,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Create your Betlink account",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  BoxField(
                    hintText: "Enter your name",
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  BoxField(
                    hintText: "Enter your email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  BoxField(
                    isPassword: true,
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                  const SizedBox(height: 25),
                  AuthElevatedButton(
                    text: "Sign Up",
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthSignUp(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      ); // go back to SignInPage
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign In",
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
          );
        },
      ),
    );
  }
}
