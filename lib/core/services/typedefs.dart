import 'package:blog_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureVoid = FutureEither<void>;

typedef DataMap = Map<String, dynamic>;
