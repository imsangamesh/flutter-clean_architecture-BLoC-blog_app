import 'package:blog_app/core/common/common_widgets.dart';
import 'package:blog_app/core/common/helper_widgets.dart';
import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen(this.blog, {super.key});

  final Blog blog;

  String get readingTime {
    final wordCount = blog.content.split(RegExp(r'\s+')).length;
    final readingTime = wordCount / 225;
    return '${readingTime.ceil()} min read';
  }

  String get posterName => blog.posterId.split(' ').sublist(1).join(' ');
  String get date => DateFormat('MMM d, y').format(blog.updatedAt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --------------------- `IMAGE`
            Hero(
              tag: blog.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kBR),
                child: Image.network(
                  blog.imageUrl,
                  height: kBannerHt,
                  width: context.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ErrorImage(),
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// --------------------- `TITLE`
            Text(blog.title, style: AppTStyles.primary),
            const SizedBox(height: 3),

            /// --------------------- `TOPICS`
            Wrap(
              children: blog.topics
                  .map((e) => Text('#$e  ', style: AppTStyles.caption))
                  .toList(),
            ),
            const SizedBox(height: 10),

            /// --------------------- `DETAILS`
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('By $posterName', style: AppTStyles.midCaption),
                const SizedBox(height: 3),
                Text('$date  •  $readingTime', style: AppTStyles.caption),
              ],
            ),
            const FullDivider(),

            /// --------------------- `CONTENT`
            Text(
              blog.content,
              style: AppTStyles.body.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
