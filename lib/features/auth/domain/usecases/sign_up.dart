import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/core/services/usecases.dart';
import 'package:blog_app/features/auth/domain/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo.dart';

class SignUp implements UseCaseWithParams<User, SignUpParams> {
  const SignUp(this.repo);

  final AuthRepo repo;

  @override
  FutureEither<User> call(SignUpParams params) async => repo.signUp(
        name: params.name,
        email: params.email,
        password: params.password,
      );
}

class SignUpParams {
  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
