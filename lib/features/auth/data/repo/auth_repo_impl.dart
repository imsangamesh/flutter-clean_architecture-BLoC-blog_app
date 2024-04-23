import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_src.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this.remoteDataSrc);

  final AuthRemoteDataSrc remoteDataSrc;

  @override
  FutureEither<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSrc.signUp(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  FutureEither<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSrc.signIn(
        email: email,
        password: password,
      );
      return right(user);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  FutureEither<void> signOut() async => right(remoteDataSrc.signOut());
}
