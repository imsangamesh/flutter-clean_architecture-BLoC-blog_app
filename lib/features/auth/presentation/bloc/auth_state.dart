part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);
  final User user;
}

final class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
}

final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}
