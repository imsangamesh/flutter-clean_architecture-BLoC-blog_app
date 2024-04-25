import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
    this.controller,
    this.label, {
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixFun,
    this.inputType,
    this.maxLength,
    this.radius,
    this.onSubmit,
    this.bottomPadding,
    this.autoFocus = false,
    this.isObscure = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final int? maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? inputType;
  final VoidCallback? suffixFun;
  final int? maxLength;
  final double? radius;
  final bool autoFocus;
  final VoidCallback? onSubmit;
  final double? bottomPadding;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 15),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is empty!';
          }
          return null;
        },
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        //
        obscureText: isObscure,
        autofocus: autoFocus,
        keyboardType: inputType ?? TextInputType.text,
        //
        style: const TextStyle(fontSize: 16),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        cursorColor: AppColors.prim,
        obscuringCharacter: '●',
        //
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: suffixFun, icon: Icon(suffixIcon))
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.transparent, width: 0),
            borderRadius: BorderRadius.circular(radius ?? kBR),
          ),
        ),
        //
        onFieldSubmitted: onSubmit == null ? null : (_) => onSubmit!(),
      ),
    );
  }
}
