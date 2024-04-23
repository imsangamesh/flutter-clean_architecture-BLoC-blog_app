import 'dart:io';

import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/core/utils/utils.dart';
import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  const ImagePickerBox({
    required this.image,
    required this.setSelectedImage,
    this.imageUrl,
    this.height = kBannerHt,
    super.key,
  });

  final File? image;
  final String? imageUrl;
  final void Function(File file) setSelectedImage;
  final double height;

  Future<void> selectImage(BuildContext context) async {
    final pickedImage = await Utils.pickImage();
    if (pickedImage == null || pickedImage.count == 0) {
      if (!context.mounted) return;
      Utils.showSnackbar(context, 'Please pick an image!');
      return;
    }

    setSelectedImage(File(pickedImage.files[0].path!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kBR),
      child: InkWell(
        onTap: () => selectImage(context),
        borderRadius: BorderRadius.circular(kBR),
        child: Ink(
          height: height,
          width: context.w,
          decoration: BoxDecoration(
            color: AppColors.listTile,
            borderRadius: BorderRadius.circular(kBR),
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: image == null
              ? const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(kBR),
                  child: Image.file(image!, fit: BoxFit.cover),
                ),
        ),
      ),
    );
  }
}
