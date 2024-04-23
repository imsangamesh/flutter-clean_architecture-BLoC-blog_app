import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/auth/domain/entity/user.dart';

abstract interface class AuthRepo {
  const AuthRepo();

  FutureEither<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  FutureEither<User> signIn({
    required String email,
    required String password,
  });
  FutureEither<void> signOut();
}
