import 'package:blog_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({this.padding, super.key});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.broken_image, size: 20, color: AppColors.opp),
          const SizedBox(width: 5),
          const Text('No internet connection!'),
        ],
      ),
    );
  }
}
