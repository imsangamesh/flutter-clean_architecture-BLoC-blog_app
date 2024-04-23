import 'package:blog_app/core/services/typedefs.dart';

abstract interface class UseCaseWithParams<Type, Params> {
  FutureEither<Type> call(Params params);
}

abstract interface class UseCaseWithoutParams<Type> {
  FutureEither<Type> call();
}
