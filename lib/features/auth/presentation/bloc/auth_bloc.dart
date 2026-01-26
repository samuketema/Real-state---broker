import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:realstate/features/auth/domain/entities/user.dart';
import 'package:realstate/features/auth/domain/usecases/user_log_in.dart';
import 'package:realstate/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  AuthBloc({required UserSignUp userSignUp, required UserLogIn userLogIn})
    : _userSignUp = userSignUp,
      _userLogIn = userLogIn,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp.call(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
    on<AuthLogIn>((event, emit) async {
      final res = await _userLogIn.call(
        UserLogInParams(email: event.email, password: event.password),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
  }
}
