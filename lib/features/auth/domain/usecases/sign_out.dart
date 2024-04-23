import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/core/services/usecases.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo.dart';

class SignOut implements UseCaseWithoutParams<void> {
  const SignOut(this.repo);

  final AuthRepo repo;

  @override
  FutureEither<void> call() => repo.signOut();
}
