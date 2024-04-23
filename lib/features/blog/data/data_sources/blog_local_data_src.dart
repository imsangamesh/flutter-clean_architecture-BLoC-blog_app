import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:get_storage/get_storage.dart';

abstract interface class BlogLocalDataSrc {
  Future<void> uploadLocalBlogs(List<BlogModel> blogs);
  Future<List<BlogModel>> loadLocalBlogs();
}

class BlogLocalDataSrcImpl implements BlogLocalDataSrc {
  const BlogLocalDataSrcImpl(this.box);

  final GetStorage box;

  @override
  Future<void> uploadLocalBlogs(List<BlogModel> blogs) async {
    try {
      await box.write(BoxKeys.blogs, blogs.map((e) => e.toMap()).toList());
    } catch (e) {
      throw ApiException("Couldn't store blogs locally! $e");
    }
  }

  @override
  Future<List<BlogModel>> loadLocalBlogs() async {
    try {
      final blogMaps = box.read<List<dynamic>>(BoxKeys.blogs);
      if (blogMaps == null) return [];
      final blogs =
          blogMaps.map((e) => BlogModel.fromMap(e as DataMap)).toList();
      return blogs;
    } catch (e) {
      throw ApiException("Couldn't load local blogs! $e");
    }
  }
}
