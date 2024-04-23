import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/entity/user.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
    required SignOut signOut,
    required GetStorage box,
  })  : _signUp = signUp,
        _signIn = signIn,
        _signOut = signOut,
        _box = box,
        super(const AuthInitial()) {
    //
    on<AuthEvent>((event, emit) => emit(const AuthLoading()));
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthSignOut>(_onSignOut);
  }

  final SignUp _signUp;
  final SignIn _signIn;
  final SignOut _signOut;
  final GetStorage _box;

  /// ---------------------------------------- `GETTERS`

  UserModel? get user {
    final userMap = _box.read<DataMap>(BoxKeys.user);
    return userMap == null ? null : UserModel.fromMap(userMap);
  }

  /// ---------------------------------------- `METHODS`

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final result = await _signUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignOut(AuthSignOut _, Emitter<AuthState> emit) async {
    await _signOut();
    emit(const AuthSignedOut());
  }
}
