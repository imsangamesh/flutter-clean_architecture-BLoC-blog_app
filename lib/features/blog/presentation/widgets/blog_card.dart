import 'package:blog_app/core/common/helper_widgets.dart';
import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/core/utils/nav_utils.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_details_screen.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard(this.blog, {super.key});

  final Blog blog;

  String get readingTime {
    final wordCount = blog.content.split(RegExp(r'\s+')).length;
    final readingTime = wordCount / 225;
    return '${readingTime.ceil()} min';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavUtils.to(context, BlogDetailsScreen(blog)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBR),
          color: AppColors.listTile,
        ),
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
                  errorBuilder: (_, __, ___) => const ErrorImage(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --------------------- `TITLE`
                  Text(blog.title, style: AppTStyles.primary),
                  const SizedBox(height: 5),

                  /// --------------------- `TOPICS`
                  Wrap(
                    children: blog.topics
                        .map((e) => Text('#$e  ', style: AppTStyles.caption))
                        .toList(),
                  ),
                ],
              ),
            ),

            /// --------------------- `READING TIME`
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBG,
                  border: Border.all(color: AppColors.listTile),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(kBR),
                    topLeft: Radius.circular(kBR),
                  ),
                ),
                child: Text(readingTime, style: AppTStyles.midCaption),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
