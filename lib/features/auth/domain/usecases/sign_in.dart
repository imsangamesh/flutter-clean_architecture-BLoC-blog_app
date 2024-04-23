import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/core/services/usecases.dart';
import 'package:blog_app/features/auth/domain/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo.dart';

class SignIn implements UseCaseWithParams<User, SignInParams> {
  const SignIn(this.repo);

  final AuthRepo repo;

  @override
  FutureEither<User> call(SignInParams params) async => repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams {
  SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
