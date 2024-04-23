import 'package:blog_app/core/common/common_widgets.dart';
import 'package:blog_app/core/utils/error_text.dart';
import 'package:blog_app/core/utils/nav_utils.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/screens/add_new_blog_screen.dart';
import 'package:blog_app/features/blog/presentation/widgets/app_drawer.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  //
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(const BlogFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () => NavUtils.to(context, const AddNewBlogScreen()),
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogFailure) {
            return ErrorText(state.message);
          }
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogFetchSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              itemCount: state.blogs.length,
              itemBuilder: (context, i) {
                final blog = state.blogs[i];

                return BlogCard(blog);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
