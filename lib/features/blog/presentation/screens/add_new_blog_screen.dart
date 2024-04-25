import 'dart:io';

import 'package:blog_app/core/common/common_widgets.dart';
import 'package:blog_app/core/common/widgets/custom_textfield.dart';
import 'package:blog_app/core/common/widgets/image_picker_box.dart';
import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/core/utils/nav_utils.dart';
import 'package:blog_app/core/utils/utils.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/screens/blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];

  final titleCntr = TextEditingController();
  final contentCntr = TextEditingController();
  File? image;
  final List<String> selectedTopics = [];

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleCntr.dispose();
    contentCntr.dispose();
  }

  void toggleSelect(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
    setState(() {});
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: context.user!.id,
              title: titleCntr.text.trim(),
              content: contentCntr.text.trim(),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

  bool _isSelected(String topic) => selectedTopics.contains(topic);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailure) {
          Utils.showSnackbar(context, state.message);
        }
        if (state is BlogUploadSuccess) {
          NavUtils.offAll(context, const BlogsScreen());
          Utils.showSnackbar(context, 'Blog posted successfully!');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state is BlogLoading)
                const Loader()
              else
                IconButton(
                  onPressed: uploadBlog,
                  icon: const Icon(Icons.done_all),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  /// --------------------- `IMAGE PICKER`
                  StatefulBuilder(
                    builder: (context, setImage) {
                      return ImagePickerBox(
                        image: image,
                        setSelectedImage: (file) =>
                            setImage(() => image = file),
                      );
                    },
                  ),

                  /// ------------------------- `CATEGORIES`
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: topics
                          .map(
                            (topic) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                selected: _isSelected(topic),
                                onSelected: (_) => toggleSelect(topic),
                                label: Text(topic),
                                side: _isSelected(topic)
                                    ? null
                                    : BorderSide(color: AppColors.listTile),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// --------------------- `TITLE`
                  AppTextField(titleCntr, 'Title', maxLines: null),

                  /// --------------------- `CONTENT`
                  AppTextField(contentCntr, 'Content', maxLines: null),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
