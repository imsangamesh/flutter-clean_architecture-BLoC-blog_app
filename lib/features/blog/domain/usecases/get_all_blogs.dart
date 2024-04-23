import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/core/services/usecases.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repo.dart';

class GetAllBlogs implements UseCaseWithoutParams<List<Blog>> {
  GetAllBlogs(this.repo);

  final BlogRepo repo;

  @override
  FutureEither<List<Blog>> call() async => repo.getAllBlogs();
}
