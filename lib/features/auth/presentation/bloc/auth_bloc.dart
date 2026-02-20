import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:realstate/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/core/common/entities/user.dart';
import 'package:realstate/features/auth/domain/usecases/user_log_in.dart';
import 'package:realstate/features/auth/domain/usecases/user_loggedIn.dart';
import 'package:realstate/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  final UserLoggedin _userLoggedin;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
    required AppUserCubit appUserCubit,
    required UserLoggedin userLoggedin,
  })  : _userSignUp = userSignUp,
        _userLogIn = userLogIn,
        _userLoggedin = userLoggedin,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>emit(AuthLoading()));
    on<AuthSignUp>(_onSignUp);
    on<AuthLogIn>(_onLogIn);
    on<AuthLoggedIn>(_onLoggedIn);
  }


  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp.call(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(emit, r),
    );
  }

  Future<void> _onLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    final res = await _userLogIn.call(
      UserLogInParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(emit, r),
    );
  }

  Future<void> _onLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _userLoggedin.call(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(emit, r),
    );
  }



  void _emitAuthSuccess(Emitter<AuthState> emit, User user) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
